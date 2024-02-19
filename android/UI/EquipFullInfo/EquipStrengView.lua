--装备强化面板
local stuffList=StuffArray.New();
local stuffItems=nil;
local layout=nil;
local curDatas=nil;
-- local isEquip=true;
local orderType=1;
local baseItems={};
local expStr="<size=72>%s</size><color=#929296>/%s</color>"--经验值格式
local lvStrFormat="%s";
local recordTime=0;
local preEquip=nil;--预览升级后的装备
local aphlaCanvas=nil;
local canClick=true;
local sortID=14;
local normalPos={-40,320};
local maxPos={-40,205};
local tweenLua=nil;
local sBarTween=nil;
local cBarTween=nil;
local beforeLv=0;
local disNewTween=false;

function Awake()
	aphlaCanvas=ComUtil.GetCom(btn_strength,"CanvasGroup");
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/Grid/EquipItem",LayoutCallBack,true,0.8);
	tweenLua=UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal);
	cBarTween=ComUtil.GetCom(slider2,"ActionSliderBar");
	sBarTween=ComUtil.GetCom(slider1,"ActionSliderBar");
    local iconName = Cfgs.ItemInfo:GetByID(ITEM_ID.GOLD).icon.."_1";
	ResUtil.IconGoods:Load(mIcon,iconName);
	CSAPI.SetRTSize(mIcon,40,40);
	sBar=ComUtil.GetCom(slider1,"Slider");
	cBar=ComUtil.GetCom(slider2,"Slider");
	recordTime=CSAPI.GetRealTime();
    CreateGrids();
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.Equip_Upgrade_Ret,OnUpgradeRet);
	eventMgr:AddListener(EventType.Bag_Update,OnBagUpdate);
	ResUtil:CreateUIGOAsync("Sort/SortTop",btnTool,function(go)
		CSAPI.SetScale(go,1,1,1);
		local lua=ComUtil.GetLuaTable(go);
		lua.Init(sortID,RefreshList);
		CSAPI.SetAnchor(go,45,-10);
	end);
end

function OnInit()
	UIUtil:AddTop2("EquipStreng",root, OnClickReturn,nil,{ ITEM_ID.GOLD})
end

function OnDisable()
    -- EquipMgr:SetOrderType(EquipViewKey.Strength,orderType);
	-- EquipMgr:SetScreenData(EquipViewKey.Strength,condition);
	RecordMgr:Save(RecordMode.View,recordTime,"ui_id=" .. RecordViews.Equip);	
end

function OnOpen()
    -- condition = EquipMgr:GetScreenData(EquipViewKey.Strength);
    -- orderType=EquipMgr:GetOrderType(EquipViewKey.Strength);
    -- SetTabData();
	FuncUtil:Call(function()
		SetMask(false);
		disNewTween=true;
	end,nil,640);
    Refresh(data.equip);
end

function OnBagUpdate()
	Refresh(data.equip);
end

function Refresh(_data)
    if _data then
		if gridItem==nil then
            _,gridItem=ResUtil:CreateEquipItem(gridNode.transform);
        end
		gridItem.Refresh(_data,{isClick=false});
		gridItem.SetCount();
		gridItem.SetLockActive(false);
        CSAPI.SetText(txt_name,_data:GetName());
		RefreshContent(_data);
	end
    RefreshList();
end

function RefreshList()
    if data and data.equip then
        -- if isEquip then
        local list=EquipMgr:GetNotEquippedItem(data.equip:GetID(),false,false);
        -- else
        local list2=EquipMgr:GetMaterialEquips();
        -- end
		list2=SortMgr:Sort(sortID,list2);
		list=SortMgr:Sort(sortID,list);
		-- list2=EquipMgr:DoScreen(list2, condition);
        -- list=EquipMgr:DoScreen(list, condition)
		local source = {};
		if list2 then
			for i = 1, #list2 do
				local index=orderType==1 and #list2 or i;
				local num=stuffList:GetStuffNumByID(list2[index]:GetID())
				if list2[index]:GetCount()-num>0 then
					table.insert(source, list2[index]);
				end
				if orderType==1 then
					table.remove(list2, index);
				end
			end
		end
        if list then
            for i = 1, #list do--装备被选中后会被剔除
				local index=orderType==1 and #list or i;
				if stuffList:GetStuffByID(list[index]:GetID())==nil then
					table.insert(source, list[index]);
				end
				if orderType==1 then
					table.remove(list, index);
                end
            end
        end
		if #source>0 then
			curDatas=source;
		else
			curDatas={};
		end
		CSAPI.SetGOActive(SortNone,#curDatas<=0);
        layout:IEShowList(#curDatas);
    end
end

--获取装备等级，读取等级信息
function RefreshContent(equip)
	if equip:GetLv()<equip:GetMaxLv() then
		CSAPI.SetGOActive(txt_max,false);
		CSAPI.SetGOActive(txt_expVal,true);
		CSAPI.SetAnchor(topObj,normalPos[1],normalPos[2]);
		CSAPI.SetGOActive(stuffRoot,true);
		CSAPI.SetGOActive(maxObj,false);
	else
		-- CSAPI.SetText(txt_expVal,string.format(expStr,"MAX","MAX"));
		CSAPI.SetGOActive(txt_max,true);
		CSAPI.SetGOActive(txt_expVal,false);
		CSAPI.SetAnchor(topObj,maxPos[1],maxPos[2]);
		CSAPI.SetGOActive(stuffRoot,false);
		CSAPI.SetGOActive(maxObj,true);
		sBar.value=1;
		cBar.value=1;
	end
	local lvUpExp = 0;
	local tab = table.copy(equip);
	preEquip = EquipData(tab.data);
	local addExp=0;
	if stuffList then
		--计算当前增加的经验值和等级
		addExp=stuffList.stuffTotalExp;
		-- CSAPI.SetGOActive(txt_currLv,stuffList.stuffCount>0);
	-- else
		-- CSAPI.SetGOActive(txt_currLv,false);
	end
	preEquip:UpLevel(addExp);
	-- gridItem.SetIntensify(preEquip:GetLv().."/"..equip:GetMaxLv());
	--刷新基础属性对比
	local list={};
	for i=1,g_EquipMaxAttrNum do
		local id,add,upAdd=equip:GetBaseAddInfo(i);
		if id and add and upAdd then
			local addition=add+upAdd*equip:GetLv();
			local addition2=add+upAdd*preEquip:GetLv();
			local text="+"..EquipCommon.FormatAddtion(id,addition);
			local text2="+"..EquipCommon.FormatAddtion(id,addition2);
			if addition2>addition then
				table.insert(list,{id=id,val1=text,val3=text2,arrowType=1,val1Color="ffffff",val2Color="00ffbf"});
			else
				table.insert(list,{id=id,val1=text,val1Color="ffffff"});
			end
		end
	end
	ItemUtil.AddItems("AttributeNew2/AttributeItem10",baseItems,list,baseRoot,nil,1);
	local upLv=preEquip:GetLv()-equip:GetLv()>0 and "+"..tostring(preEquip:GetLv()-equip:GetLv()) or "";
	-- CSAPI.SetText(txt_lvVal,"<color=\"#00ffbf\">+"..preEquip:GetLv().."</color>/+"..equip:GetMaxLv()..upLv);
	CSAPI.SetGOActive(txt_addLvVal,upLv~="");
	CSAPI.SetText(txt_addLvVal,upLv);
	CSAPI.SetText(txt_lvVal,string.format(lvStrFormat,equip:GetLv()));
	CSAPI.SetGOActive(txt_addExp,addExp>0);
	CSAPI.SetText(txt_addExp,addExp>0 and "+"..tostring(addExp) or "");
	if equip:GetLv()~=equip:GetMaxLv() then
		local tempVal=0;
		if preEquip:GetLv()<=equip:GetMaxLv() then
			lvUpExp=equip:GetLvUpExp();
			local currExp=equip:GetExp()+stuffList.stuffTotalExp;
			-- cBar.value=currExp/lvUpExp;
			tempVal=upLv~="" and 1 or preEquip:GetExp()/lvUpExp;
			sBar.value=equip:GetExp()>0 and equip:GetExp()/lvUpExp or 0;
			CSAPI.SetText(txt_expVal,string.format(expStr,equip:GetExp(),lvUpExp));
		-- else
		-- 	sBar.value=equip:GetExp()>0 and equip:GetExp()/lvUpExp or 0;
		-- 	-- cBar.value=1;
		-- 	tempVal=1;
		end
		if addExp>0 then
			PlayBarTween(cBar,cBarTween,tempVal);
		else
			cBar.value=tempVal;
		end
	end
	--初始化素材信息
	local index=1;
	for k,v in ipairs(stuffList:GetStuffArr()) do
		local num=v.num==nil and 1 or v.num
		for i=1,num do
			CSAPI.SetGOActive(stuffItems[index].gameObject,true)
			stuffItems[index].Refresh(v.data);
			stuffItems[index].SetCount();
			stuffItems[index].SetClickCB(OnClickRemoveStuff);
			index=index+1;
		end
	end
	for i=stuffList.stuffCount+1,EquipMgr.maxStuffNum do
        -- stuffItems[i].Clean();
		stuffItems[i].Refresh(nil,{plus=true});
		-- CSAPI.SetGOActive(stuffItems[i].gameObject,false);
	end
	SetPrice(stuffList==nil and 0 or stuffList.stuffTotalPrice)
	if equip:GetLv()==equip:GetMaxLv() then
		SetBtns(3);
	elseif (stuffList~=nil and stuffList.stuffCount>=1) then
		SetBtns(2);
	else
		SetBtns(1);
	end
end

function SetBtns(state)
	CSAPI.SetGOActive(btn_auto,state==1);
	CSAPI.SetGOActive(btn_clean,state==2);
	CSAPI.SetGOActive(btns,state~=3);
end

function SetPrice(num)
	CSAPI.SetGOActive(priceNode,num>0);
	local color="#ffffff"
	if num>PlayerClient:GetCoin(ITEM_ID.GOLD) then
		color="#ff7781"
		aphlaCanvas.alpha=0.3;
		canClick=false;
	else
		aphlaCanvas.alpha=1;
		canClick=true;
	end
	CSAPI.SetText(txt_price,string.format("<color=%s>%s</color>",color,num));
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local grid=layout:GetItemLua(index);
	grid.SetIndex(index);
	if _data:GetType()==EquipType.Material then
		local num=0;
		if stuffList then
			num=stuffList:GetStuffNumByID(_data:GetID());
		end
		grid.Refresh(_data,{isClick = true,showNew=true,num=num,disNewTween=disNewTween});
		grid.SetCount(_data:GetCount()-num);
	else
		grid.Refresh(_data,{isClick = true,showNew=true,disNewTween=disNewTween});
	end
	grid.SetClickCB(OnClickGrid);
end

function CreateGrids()
    stuffItems={};
    for i=1,EquipMgr.maxStuffNum do
		ResUtil:CreateUIGOAsync("Grid/EquipItem",stuffRoot,function(go)
            local item=ComUtil.GetLuaTable(go);
        	-- CSAPI.SetScale(item.gameObject,1,1,1);
            -- item.Clean();
			item.Refresh(nil,{plus=true});
            table.insert(stuffItems,item);
        end);
	end
end

-- function OnClickViewType()
--     isEquip=not isEquip
--     local color1=isEquip~=true and {0,0,0,255} or {255,255,255,255}
--     local color2=isEquip and {0,0,0,255} or {255,255,255,255}
--     CSAPI.SetGOActive(offObj,not isEquip);
--     CSAPI.SetGOActive(onObj,isEquip);
--     CSAPI.SetTextColor(txt_vt1,color1[1],color1[2],color1[3],color1[4]);
--     CSAPI.SetTextColor(txt_vt2,color2[1],color2[2],color2[3],color2[4]);
--     RefreshList();
-- end

--点击强化
function OnClickStrength()
	if canClick~=true then
		return;
	end
	local array = stuffList:GetStuffArr();
	local equipIds = {};
	local goodIds = {};
	local mIds={};--用于统计哪些素材装备已经被查找过
	for k, v in ipairs(array) do
		if v.type == 0 then
			table.insert(equipIds, v.data:GetID());
		elseif v.type == 1 then
			local hasId=false;
			for _,id in ipairs(mIds) do
				if id==v.data:GetID() then
					hasId=true;
					break;
				end
			end
			if hasId==false then
				table.insert(mIds,v.data:GetID());
				table.insert(goodIds, {id = v.data:GetID(), num = stuffList:GetStuffNumByID(v.data:GetID()),type=RandRewardType.EQUIP});
			end
		end
	end
	if data.equip:GetLv() == data.equip:GetMaxLv() then
		Tips.ShowTips(LanguageMgr:GetTips(12008));
		return;
	end
	if #equipIds > 0 or #goodIds > 0 then
		beforeLv=data.equip:GetLv();
		EquipProto:EquipUpgrade(data.equip:GetID(), equipIds, goodIds);
	else
		Tips.ShowTips(LanguageMgr:GetTips(12009));
	end
end

function OnUpgradeRet(critTips)
	if critTips then
		Tips.ShowTips(critTips);
	else
		Tips.ShowTips(LanguageMgr:GetTips(12010));
	end
	--显示强化成功界面
	data.equip = EquipMgr:GetEquip(data.equip:GetID());
	--清空选择的素材信息
	stuffList:CleanStuffInfo();
	CSAPI.PlayUISound("ui_hints_error");
	local testVal=data.equip:GetLv()-beforeLv>=1 and 1 or 0;
	if	data.equip:GetLv()~=data.equip:GetMaxLv() then
		testVal=testVal+data.equip:GetExp()/data.equip:GetLvUpExp();
	end
	--播放升级动画
	PlayBarTween(sBar,sBarTween,testVal,function()
		--刷新界面
		cBar.value=0;
		Refresh(data.equip)
	end);
	EventMgr.Dispatch(EventType.Equip_Change);
end 

--一键选择
function OnClickAuto()
	if preEquip:GetLv()>=preEquip:GetMaxLv() or data.equip:GetLv()>=data.equip:GetMaxLv() then
		Tips.ShowTips(LanguageMgr:GetTips(12008));
		return;
	end
	stuffList:CleanStuffInfo();
	--获取当前强化的装备到满级的经验
	local totalExp=data.equip:GetEquipMaxLvExp();
	-- Log(totalExp)
	--计算需要的素材
	local stuffs=EquipMgr:GetMaterialEquips();
	if stuffs then
		local tempExp=0;
		local mpInfo=nil;--记录冒泡排序最接近的值和素材信息
		table.sort(stuffs,EquipSortUtil.SortEquipByMExp);
		local result,subExp,count=MatchMartials(stuffs,totalExp,EquipMgr.maxStuffNum,0);
		if result then
			for k,v in ipairs(result) do
				stuffList:AddStuffItem(v.item,1,v.count);
			end
		end
		if subExp and subExp>0 and stuffList:GetStuffIsMax()~=true then
			local diff=0;
			local tempInfo=nil;
			for k,v in ipairs(stuffs) do
				local exp=v:GetMaterialInfo().exp
				local tempDiff=exp-subExp;
				local count=stuffList:GetStuffNumByID(v:GetID());
				local hasMore=v:GetCount()>count and true or false;
				if tempInfo==nil and exp>subExp and hasMore then
					tempInfo=v;
					diff=tempDiff;
				elseif exp>subExp and tempDiff<diff and tempDiff>=0 and hasMore then
					tempInfo=v;
					diff=tempDiff;
				end
			end
			if tempInfo and diff<300 then
				stuffList:AddStuffItem(tempInfo,1);
			end
		end
	end
	local ids=nil;
	if stuffList.stuffTotalExp<totalExp and stuffList:GetStuffIsMax()==false then
		--获取装备列表
		local list=EquipMgr:GetNotEquippedItem(data.equip:GetID(),false,false);
		--排序
		table.sort(list,EquipSortUtil.SortEquipRevers);
		for k,v in ipairs(list) do
			--取最前面的几个
			if v:GetExp()==0 and v:GetLv()==0 and v:GetQuality()<5 then
				stuffList:AddStuffItem(v,0);
			end
			if stuffList:GetStuffIsMax() or stuffList.stuffTotalExp>=totalExp then
				break;
			end
		end
	end
	if stuffList.stuffCount>0 then --被选中的装备取消new状态
		for k,v in pairs(stuffList.stuffList) do
			ids=ids or {};
			local hasId=false;
			for _,val in ipairs(ids) do
				if val==v.data:GetID() then
					hasId=true;
					break;
				end
			end
			if hasId~=true and v.data:IsNew() then
				stuffList.stuffList[k].data:SetNew(false);--本地设置为false
				table.insert(ids,v.data:GetID());
			end
		end
	end
	if ids~=nil and #ids>0 then
		EquipProto:SetIsNew(ids);
	end
	--刷新界面
	Refresh(data.equip);
end

function MatchMartials(list,totalExp,totalCount,currCount,canStop)
	local countList=nil;--记录当前每种素材升级所需的数量
	local ctCount=currCount or 0;
	local tempExp=totalExp or 0;
	local subExp=0;
	for k,v in ipairs(list) do
		local exp=v:GetMaterialInfo().exp
		local count=math.floor(tempExp/exp);
		if count>=v:GetCount() then
			count=v:GetCount()
		end
		if ctCount+count>totalCount then
			count=totalCount-ctCount;
		end
		ctCount=ctCount+count;
		subExp=tempExp-exp*count;
		tempExp=subExp;
		if count>0 then
			countList=countList or {};
			table.insert(countList,{count=count,item=v});
		end
		if subExp<=0 or currCount>=totalCount or canStop then
			break;
		else
			local ret,sExp=MatchMartials(list,subExp,totalCount,ctCount,true);
			if ret~=nil then
				subExp=sExp;
				countList=countList or {};
				table.insert(countList,ret);
			end
		end
	end
	return countList,subExp,ctCount;
end

function OnClickClean()
	if stuffList then
		stuffList:CleanStuffInfo();
		Refresh(data.equip);
	end
end

function OnClickReturn()
    view:Close();
end

function OnClickGrid(tab)
    --添加到stuffList中，并增加剔除id
	--设置new
	if tab.data:IsNew() then
		EquipProto:SetIsNew({tab.data:GetID()}, function() 
			tab.data:SetNew(false);
			tab.SetNewState(tab.data:IsNew());
		end);
    end
    if stuffList:GetStuffIsMax() == false and ((tab.GetAddNum()<tab.data:GetCount() and tab.data:GetType()==EquipType.Material) or tab.data:GetType()==EquipType.Normal) then
		if (preEquip~=nil and preEquip:GetLv()<preEquip:GetMaxLv()) then
			stuffList:AddStuffItem(tab.data,tab.data:GetType()==EquipType.Material and 1 or 0);
			if tab.data:GetType()==EquipType.Material then
				tab.SetChoosie(true);
				tab.SetAddNum(tab.GetAddNum()+1);
			end
			Refresh(data.equip);
			-- RefreshList();
		else
			-- Tips.ShowTips(LanguageMgr:GetTips(12008));
			Tips.ShowTips(LanguageMgr:GetTips(12016))
		end
    else
        Tips.ShowTips(LanguageMgr:GetTips(12011));
    end
end

function OnClickRemoveStuff(tab)
	local index=1;
	for k,v in ipairs(stuffItems) do
		if v==tab and stuffList then
			stuffList:RemoveStuffItemByIndex(k);
			break;
		end
	end
	Refresh(data.equip)
end

function PlayBarTween(slider,tween,val,func)
	if tween and val>0 then
		--计算时间
		local currVal=slider.value;
		tween.target=slider.gameObject;
		tween.targetVal=val;
		local time=val>1 and (1-currVal)*500 or val*500;
		cBarTween.time=time;
		sBarTween.time=time;
		local isLvUp=val>=1;
		SetMask(true);
		tween:Play(function()
			if isLvUp and slider~=cBar then
				slider.value=0;
				CSAPI.SetGOActive(upImg,true);
				FuncUtil:Call(function()
					CSAPI.SetGOActive(upImg,false);
					if data.equip:GetLv()<data.equip:GetMaxLv() then
						PlayBarTween(slider,tween,(val-1),func);
					else
						slider.value=1;
						SetMask(false);
						func();
					end
				end,nil,150);
			elseif func then
				SetMask(false);
				func();
			else
				SetMask(false);
			end
		end);
	else
		slider.value=val;
		SetMask(false);
		if func then
			func();
		end
	end
end

function SetMask(isShow)
	CSAPI.SetGOActive(mask,isShow);
end

------------------------筛选
--[[
--页签数据
function SetTabData()
    --升降
    orderType = EquipMgr:GetOrderType(EquipViewKey.Strength);
    local rota = orderType == 2 and 180 or 0
    CSAPI.SetRectAngle(objSort, 0, 0, rota)
    local id=condition.Sort[1];
    local str = Cfgs.CfgEquipSortEnum:GetByID(id).sName or ""
	CSAPI.SetText(txtSort, str)
end

function OnClickFiltrate()
    local mData = {}
	--需要单选
	mData.single = {["Sort"] = 1} --1无意义
    mData.list = {"Sort","Qualiy","skill"}
    mData.titles = {LanguageMgr:GetByID(24004),LanguageMgr:GetByID(24005),LanguageMgr:GetByID(24019)}
	--当前数据
	mData.info = condition
	--源数据
	local _root = {}
	_root.Sort="CfgEquipSortEnum";
	_root.Qualiy = "CfgEquipQualityEnum"
    _root.skill=EquipCommon.GetFilterSkillList();
    -- for k,v in pairs(Cfgs.CfgEquipSkillTypeEnum.datas_ID) do
    --     if v.group then
    --         table.insert(_root.skill,{id=v.id,sName=v.sName});
    --     end
	-- end
	-- table.sort(_root.skill,function(a,b)
	-- 	return a.id<b.id;
	-- end)
	mData.root = _root
	--回调
	mData.cb = OnSort
	CSAPI.OpenView("SortView", mData)
end

function OnClickUD()
    orderType = orderType==1 and 2 or 1;
    local rota = orderType == 2 and 180 or 0
    CSAPI.SetRectAngle(objSort, 0, 0, rota)
    RefreshList();
end

--筛选完毕
function OnSort(newInfo)
    condition=newInfo;
    local id=condition.Sort[1];
    local str = Cfgs.CfgEquipSortEnum:GetByID(id).sName or ""
	CSAPI.SetText(txtSort, str)
    RefreshList();
end
]]
function OnDestroy()
	eventMgr:ClearListener();
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
root=nil;
leftObj=nil;
vsv=nil;
btnTool=nil;
txtFiltrate=nil;
btnUD=nil;
objSort=nil;
txtSort=nil;
btn_auto=nil;
txt_auto=nil;
txt_autoTips=nil;
rightObj=nil;
gridNode=nil;
txt_name=nil;
baseRoot=nil;
stuffRoot=nil;
btn_strength=nil;
txt_strength=nil;
txt_strengthTips=nil;
mIcon=nil;
txt_price=nil;
slider2=nil;
slider1=nil;
txt_lvVal=nil;
txt_expVal=nil;
view=nil;
cBarTween=nil;
cBar=nil
sBar=nil
sBarTween=nil;
end
----#End#----