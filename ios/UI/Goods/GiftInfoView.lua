--礼包信息界面
local item = nil;
local rewardCfg = nil;
local items=nil;
local selectID=nil;
local layout=nil;
local useNum=1;
local maxNum=0;
local minNum = 1;--最少使用数量

function Awake()
	layout = ComUtil.GetCom(vsv, "UISV");
	layout:Init("UIs/Common/GridChoosieItem",LayoutCallBack,true)
end

function LayoutCallBack(index)
	local _data = curDatas[index]
	local grid=layout:GetItemLua(index);
	local elseData={isSelect=false,useNum=useNum};
	if selectID==_data.cfg.index then
		elseData={isSelect=true,useNum=useNum};
	end
	grid.Refresh(_data,elseData);
	grid.SetClickCB(OnClickGridChoosieItem);
end

function OnOpen()
	-- UIUtil:ShowAction(child,function()
		if data ~= nil then
			item = data.info;
			rewardCfg = data.rewardCfg;
			SetData();
			CSAPI.SetText(txt_title,item:GetName());
			CSAPI.SetGOActive(btn_open,data.showBtn);
			Refresh();
		end
	-- end, UIUtil.active2);
end

function SetData()
	--初始化礼品礼包中的物品
	curDatas={};
	LoadCfgs(rewardCfg,1);
end

function LoadCfgs(cfg,count)
	if cfg then
		if cfg.type == RewardRandomType.FIXED then --只显示固定类型
			local list = cfg.item;
			if list then
				for k, v in ipairs(list) do
					if v.type == RewardRandomType.FIXED then
						local rCfg = Cfgs.RewardInfo:GetByID(v.id);
						LoadCfgs(rCfg,v.count);
					else
						table.insert(curDatas,{id=v.id,type=v.type,num=v.count,cfg=v});
					end
				end
			end
		elseif cfg.type==RewardRandomType.SINGLE_SELECT then --选择固定类型
			local list=cfg.item;
			if list then
				for k,v in ipairs(list) do
					table.insert(curDatas,{id=v.id,type=v.type,num=v.count,cfg=v});
				end
			end
		else	--随机
			table.insert(curDatas,{id=cfg.id,type=cfg.type,num=count,cfg=cfg});
		end
	end
end

--初始化礼包
function Refresh()
	maxNum=item:GetCount()<g_MaxUseItem and item:GetCount() or g_MaxUseItem;
	CSAPI.SetText(txt_currNum,tostring(item:GetCount()));
	CSAPI.SetText(txt_num, tostring(useNum));
	layout:IEShowList(#curDatas);
end

--点击礼包中的物品
function OnClickGridChoosieItem(item)
	selectID=item.sourceData.cfg.index;
	layout:UpdateList();
end

function OnClickAnyWay()
	Close();
end

function Close()
	UIUtil:HideAction(child, function()
		if  view~=nil then
			view:Close();
		end
	end, UIUtil.active4);
end

--点击购买
function OnClickOpen()
	if selectID~=nil then
		local index=nil;
		local id= item:GetID();
		local data=item:GetData();
		if data and data.get_infos then
			index=data.get_infos[1].index;
			id=item:GetCfg().to_item_id;
		end
		--打开礼包
		PlayerProto:UseItem({
			id=id,
			ix=index,
			cnt=useNum,
			arg1=selectID,
		}, true);
		Close();
	else
		Tips.ShowTips(LanguageMgr:GetByID(24028))
	end	
end

function OnDestroy()    
    ReleaseCSComRefs();
end

function SetBtnState(btn, img, enable)
	if btn then
		-- local color = enableColor;
		if enable then
			btn.enabled = enable;
		else
			btn.enabled = false;
			-- color = disableColor;
		end
		-- if img then
		-- 	CSAPI.SetImgColor(img.gameObject, color[1], color[2], color[3], color[4]);
		-- end
	end
end

function OnClickAdd()
	if useNum < maxNum then
		useNum = useNum + 1;
		CSAPI.SetText(txt_useNum, tostring(useNum));
		layout:UpdateList();
	else
		Tips.ShowTips(LanguageMgr:GetByID(24025));			
	end
	-- SetBtnState(removeBtn, removeImg, useNum > 1);
	-- SetBtnState(addBtn, addImg, useNum < maxNum);
end

function OnClickRemove()
	if useNum > minNum then
		useNum = useNum - minNum;
		CSAPI.SetText(txt_useNum, tostring(useNum));	
		layout:UpdateList();
	else
		Tips.ShowTips(LanguageMgr:GetByID(24026));	
	end
	-- SetBtnState(removeBtn, removeImg, useNum > 1);
	-- SetBtnState(addBtn, addImg, useNum < maxNum);
end

function OnClickMax()
	useNum = maxNum;
	-- SetBtnState(removeBtn, removeImg, useNum > 1);
	-- SetBtnState(addBtn, addImg, false);
	CSAPI.SetText(txt_useNum, tostring(useNum));	
	layout:UpdateList();
end 

function OnClickMin()
	useNum = minNum;
	-- SetBtnState(removeBtn, removeImg, useNum > 1);
	-- SetBtnState(addBtn, addImg, useNum < maxNum);
	CSAPI.SetText(txt_useNum, tostring(useNum));	
	layout:UpdateList();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
child=nil;
name=nil;
gridNode=nil;
Content=nil;
text_open=nil;
text_tips=nil;
view=nil;
end
----#End#----