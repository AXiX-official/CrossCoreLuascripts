--拖拽卡牌视图
local isDamage = false;
local stars=nil;
local gridSize=nil;
local attrs={};
local maxAttrNum=2;--每次最大显示的数量
local attrIndex=1;--光环属性的显示下标
local currTime=0;
local loopTime=6;--循环时间
local haloInfos=nil;
local descTxts=nil;
function Awake()
	local imgs = ComUtil.GetComsInChildren(gameObject, "Image", true);
	upTween = ComUtil.GetCom(txt_topAddVal, "ActionNumberRunner");
    downTween = ComUtil.GetCom(txt_downAddVal, "ActionNumberRunner");
	descTxts={{txt_topAdd,txt_topAddVal,upTween},{txt_downAdd,txt_downAddVal,downTween}};
end

--设置数据 k:当前
function InitData(data,isLeader,_isMini,_isMirror)
	isMirror = _isMirror==nil and false or _isMirror
	if(isMirror) then 
		SetDragEnable()
	end
	-- SetStyle(_isMini);
	if data == nil then
		this.data=nil;
		LogError("卡牌数据不能为nil");
		return
	end
	this.data=data;

	if data.bIsNpc==false and not isMirror then
		local cfg=data:GetModelCfg();
		if cfg~=nil then
			FormationUtil.Load2DImg(icon,cfg,data:GetGrids());
		end
		-- ResUtil.FormationIcon:Load(icon,cfg.formation_icon);
		SetGridSize(data:GetGrids());
	else
		local cfg=data:GetCfg();
		if cfg~=nil then
			skinID=cfg.model;
        end
        local modelCfg=Cfgs.character:GetByID(skinID);
		if modelCfg then
			FormationUtil.Load2DImg(icon,modelCfg,data:GetGrids());
		end
        -- ResUtil.FormationIcon:Load(icon,modelCfg.formation_icon);
        SetGridSize(cfg.grids);
    end
	SetHaloCfg();
	CSAPI.SetText(txt_lv,tostring(data:GetLv()));
	SetSupport(data:IsAssist());
	local isFight=TeamMgr:GetCardIsDuplicate(data:GetID());
	SetFightObj(isFight);
	SetTips();
	-- CSAPI.SetGOActive(attrObj,false);
	ShowArrow(false);
end


function SetHaloCfg()
	if this.data then
		local cfg=this.data:GetCfg();
        if(cfg.gridsIcon) then --光环范围
            ResUtil.RoleSkillGrid:Load(haloIcon, cfg.gridsIcon)
            CSAPI.SetRTSize(haloIcon,60,60);
        end
        --读取光环加成
        local desc="";
        local index=1;
        if cfg.halo then
            local haloCfg=Cfgs.cfgHalo:GetByID(cfg.halo[1]);
            for k,v in ipairs(haloCfg.use_types) do
                local attrCfg=Cfgs.CfgCardPropertyEnum:GetByID(v);
                if attrCfg then
                    local num =haloCfg[attrCfg.sFieldName] or 0;
                    local addtive=0;
                    local endStr="";
                    if v~=4 then --除速度外所有加成以百分比显示
                        addtive = tonumber(string.match(num * 100, "%d+"));
                        endStr="%"
                    else
                        addtive=num;
                    end
                    CSAPI.SetText(descTxts[index][1],attrCfg.sName2);
                    -- CSAPI.SetText(descTxts[index][2],addtive);
                    descTxts[index][3].currentNum = 0;
                    descTxts[index][3].fixedBStr=endStr;
                    descTxts[index][3].targetNum = addtive;
                    descTxts[index][3]:Play();
                    index=index+1;
                end
            end
        end
        CSAPI.SetGOActive(topLine,index>1);
	end
end

function SetTween(isShow)
	CSAPI.SetGOActive(tweenObj,isShow);
	CSAPI.SetGOActive(attrTween,isShow);
end

function SetTips()
	if data then
		CSAPI.SetGOActive(tipsIcon,true);
		if data:IsLeader() then
			FormationUtil.LoadTipsIcon(tipsIcon,1);
		elseif data:IsNPC() then
			FormationUtil.LoadTipsIcon(tipsIcon,3);
		elseif data:IsAssist() then
			FormationUtil.LoadTipsIcon(tipsIcon,2);
		else
			CSAPI.SetGOActive(tipsIcon,false);
		end
	else
		CSAPI.SetGOActive(tipsIcon,false);
	end
end

function HideHaloAtts()
	if attrObj.activeSelf then
		CSAPI.SetGOActive(lvTween,true);
	end
	CSAPI.SetGOActive(attrObj,false)
	CSAPI.SetAnchor(lvObj,116,22)
end

--受到的光环加成属性
function CreateHaloAtts(infos)
	CSAPI.SetGOActive(attrObj,true);
	CSAPI.SetAnchor(lvObj,116,96)
	CSAPI.SetGOActive(lvTween,false);
	if infos then
		haloInfos=infos;
		if #infos>maxAttrNum then
			isLoop=true;
			currTime=loopTime;
			attrIndex=1;
		else
			isLoop=false;
			FormationUtil.CreateAttrs(haloInfos,attrs,attrNode,true);
		end
		CSAPI.SetGOActive(attrTri,isLoop==true);
		CSAPI.SetGOActive(attrNode,#infos>0);
		CSAPI.SetGOActive(txt_noneAttr,#infos<=0);
	else
		CSAPI.SetGOActive(txt_noneAttr,true);
	end
end

function Update()
	if isLoop then --光环属性大于4条时每间隔五秒循环显示
		currTime=currTime+Time.deltaTime;
		if currTime>=loopTime then
			local list={};
			for i=attrIndex,(attrIndex+maxAttrNum-1) do
				if haloInfos[i]~=nil then
					table.insert(list,haloInfos[i]);
				else
					break;
				end
			end
			CSAPI.ApplyAction(attrNode,"Img_Fade_To_Out",function()
				if gameObject then
					FormationUtil.CreateAttrs(list,attrs,attrNode,true);
					CSAPI.ApplyAction(attrNode,"Img_Fade_To_In");
				end
			end);
			attrIndex=attrIndex+maxAttrNum>#haloInfos and 1 or attrIndex+maxAttrNum
			currTime=0;
		end
	end
end

function SetFightObj(_isShow)
	local isShow=_isShow==true and true or false;
	CSAPI.SetGOActive(fightingObj,isShow);
end

function SetGridColor(type)
	local color=FormationUtil.GetHalo2DGridColor(type)
	local color2=FormationUtil.GetHalo2DBorderColor(type)
	CSAPI.SetImgColor(bnode,color2[1],color2[2],color2[3],color2[4]);
    CSAPI.SetImgColor(border,color[1],color[2],color[3],color[4]);
end

function SetGridSize(gridType)
    local size=FormationUtil.GetGridSize(gridType,false);
	local size2=FormationUtil.GetBgSize(gridType,false);
	CSAPI.SetRectSize(bg,size2[1],size2[2]);
	CSAPI.SetRectSize(border,size[1],size[2]);
    CSAPI.SetRectSize(gameObject,size[1],size[2]);
end

function SetSelectModel(isShow)
	isShow=isShow==true and true or false;
	CSAPI.SetGOActive(lvObj,not isShow);
	SetTopMask(isShow);
end

function SetTopMask(isShow)
	CSAPI.SetGOActive(topmask,isShow);
end

-- function SetGridImg(row,col,coord)
-- 	local bgName="btn_4_03.png";
-- 	local rotate=0;
-- 	local iRow=row;
-- 	local iCol=col;
-- 	if coord then
-- 		for k,v in ipairs(coord) do
-- 			local r = row + v[1] - 1;
-- 			local c = col + v[2] - 1;
-- 			if r==3 and c==3 then
-- 				iRow=3;
-- 				iCol=3;
-- 				break;
-- 			end
-- 		end
-- 	end
-- 	if iRow==1 and iCol==1 then
-- 		bgName="btn_4_07.png";
-- 	elseif iRow==3 and iCol==3 then
-- 		bgName="btn_4_06.png";
-- 	elseif iRow==3 and iCol==1 then
-- 		rotate=180;
-- 	end
-- 	CSAPI.LoadImg(bg,"UIs/Formation/"..bgName,false,nil,true);
-- 	CSAPI.SetRectAngle(bg,0,0,rotate);
-- 	if row ==3 and col ==1 then
-- 		CSAPI.SetAngle(node,0,0,180);
-- 	else
-- 		CSAPI.SetAngle(node,0,0,0);
-- 	end
-- end

--设置位置
function SetParent(go, offset)
	if go and offset then
        --设置新的父物体
		CSAPI.SetParent(gameObject, go)
		--设置位置
		CSAPI.SetLocalPos(gameObject, offset.x, offset.y, offset.z);
	end
end

function ShowArrow(isShow)
	-- CSAPI.SetGOActive(choosieObj,isShow);
end

--移动 pos:世界坐标
function Move(pos)
	transform.position=pos;
end

--设置物体层级
function SetSibling()
	CSAPI.SetParent(gameObject, view.myParent.parent.gameObject)
	transform:SetAsLastSibling();
end

function Close()
	if(luaModel) then
		luaModel.Remove();
		luaModel=nil;
	end
	view:Close();
end

function SetSupport(isShow)
	CSAPI.SetGOActive(supportObj,isShow or false);
end

--用来验证是否可以被放置到阵型的物体
function GetTag()
	return "TeamDrag"
end

function GetPos()
	local x,y,z =CSAPI.GetPos(gameObject);
	return x,y,z;
end

-----------------------演习-------------------------------------------------
--禁用拖拽
function SetDragEnable()
	local drag =  ComUtil.GetCom(gameObject, "DragCallLua")
	drag.enabled = false
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
bg=nil;
bnode=nil;
node=nil;
icon=nil;
attrObj=nil;
attrNode=nil;
txt_noneAttr=nil;
lvObj=nil;
txt_lv=nil;
border=nil;
tipsObj=nil;
tipsIcon=nil;
txt_tips=nil;
view=nil;
end
----#End#----