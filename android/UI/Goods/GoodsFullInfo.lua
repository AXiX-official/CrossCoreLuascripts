--物品信息界面
local useNum = 1;--当前使用的道具数据
local minNum = 1;--最少使用数量
local maxNum = 10;--当前使用的道具最大数量
local clickFunc = nil; --点击开启按钮的回调方法
local enableColor = {225, 116, 0, 255};
local disableColor = {77, 77, 77, 255};
local okBtn = nil;
local addBtn = nil;
local maxBtn=nil;
local minBtn=nil;
local removeBtn = nil;
local hasGet=false;
local getItems={};
local buildItems={};
local otherItems={};
local otherItems2={};
local itemInfo=nil;
local eventMgr=nil;
local expiryTime=nil;
local isUse=false;
local defaultSize={0,0};
-- local slider=nil;
function Awake()
	addBtn = ComUtil.GetCom(btn_add, "Button");
	removeBtn = ComUtil.GetCom(btn_remove, "Button");
	maxBtn = ComUtil.GetCom(btn_max, "Button");
	minBtn = ComUtil.GetCom(btn_min, "Button");
	-- slider = ComUtil.GetCom(numSlider, "Slider");
	-- CSAPI.AddSliderCallBack(numSlider, SliderCB)
	CSAPI.PlayUISound("ui_popup_open")
	defaultSize=CSAPI.GetRTSize(svc);
end

function OnEnable()
	CSAPI.SetGOActive(bottomObj, false);
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.View_Lua_Closed, this.OnViewClose);
	eventMgr:AddListener(EventType.Bag_Update, OnBagChange);
	eventMgr:AddListener(EventType.Equip_Update, OnEquipChange);
	CSAPI.SetGOActive(numObj, false);
end

function OnDisable()
	eventMgr:ClearListener();
end

function OnViewClose(event)
	if data and data.key==event then
		Close();
	end
end

function OnBagChange()
	if data and data.data~=nil then
		data.data=BagMgr:GetData(data.data:GetID());
		itemInfo=data.data;
		if itemInfo==nil and isUse~=true then
			Close();
			return;
		end
	end
	Refresh();
end

function OnEquipChange()
	Refresh();
end

function OnOpen()
	if data then
		itemInfo=data.data;
	end
	Refresh();
	if openSetting~=nil then
		CSAPI.SetGOActive(bottomObj, false);
	end
	-- if openSetting ~= nil and openSetting == 2 then --奖励、结算、商城 会重新从背包中获取相应物品数据
	-- 	CSAPI.SetGOActive(bottomObj, false);
	-- elseif openSetting == 3 then--不显示持有数的情况
	-- 	-- CSAPI.SetGOActive(currNumObj, false);
	-- 	CSAPI.SetGOActive(bottomObj, false);
	-- elseif openSetting == 4 then --图鉴
	-- 	-- CSAPI.SetGOActive(numObj, false);
	-- 	-- CSAPI.SetGOActive(btn_ok, false);
	-- 	CSAPI.SetGOActive(bottomObj, false);
	-- end
	-- SetBgHeight();
end

function Refresh()
	if itemInfo then
		--初始化物品信息
		-- if gridItem == nil then
		-- 	_, gridItem = ResUtil:CreateGridItem(gridNode.transform);
		-- end
		-- gridItem.Refresh(itemInfo, {isClick = false});
		-- gridItem.SetCount();
		local cfg = itemInfo:GetCfg();
		local isShow=false;
		if cfg and cfg.type==ITEM_TYPE.PANEL_IMG then--多人插图,特殊处理
			ResUtil.MultiIcon:Load(icon,cfg.itemPicture);
			CSAPI.SetScale(icon,0.63,0.63,0.63);
			CSAPI.SetGOActive(btnDetails,true);
		elseif cfg and cfg.type==ITEM_TYPE.FORNITURE then --家具，特殊处理
			isShow=true;
			local loader=itemInfo:GetIconLoader();
			if loader then
				loader:Load(icon, itemInfo:GetIcon())
			end
			CSAPI.SetScale(icon,1,1,1);
			CSAPI.SetGOActive(btnDetails,false);
			if cfg.dy_value1 then
				local dormCfg=Cfgs.CfgFurniture:GetByID(cfg.dy_value1)
				CSAPI.SetText(txtComfort, dormCfg.comfort .. "")
			end
		elseif cfg and cfg.type==ITEM_TYPE.CARD then --卡牌，特殊处理
			GridUtil.LoadCIcon(icon,tIcon,itemInfo:GetCfg(),false);
			CSAPI.SetScale(icon,1,1,1);
		elseif itemInfo:GetClassType()=="CharacterCardsData" then --卡牌数据类型
			GridUtil.LoadCIconByCard(icon,tIcon,itemInfo:GetCfg(),false)
			CSAPI.SetScale(icon,1,1,1);
		else
			local loader=itemInfo:GetIconLoader();
			if loader then
				loader:Load(icon, itemInfo:GetIcon())
			end
			CSAPI.SetScale(icon,1,1,1);
			CSAPI.SetGOActive(btnDetails,false);
		end
		CSAPI.SetGOActive(dormTips,isShow);
		local quality=itemInfo:GetQuality();
		ResUtil:LoadBigImg(gridNode, string.format("UIs/Goods/img_06_0%s" ,quality or 1), true);
		-- maxNum = itemInfo:GetCount() < g_MaxUseItem and itemInfo:GetCount() or g_MaxUseItem;
		if cfg and cfg.useTimes then--特定物品的单次使用上限
			maxNum = itemInfo:GetCount() < cfg.useTimes and itemInfo:GetCount() or cfg.useTimes;
		else
			maxNum = itemInfo:GetCount() < g_MaxUseItem and itemInfo:GetCount() or g_MaxUseItem;
		end
		CSAPI.SetText(txt_name, itemInfo:GetName());
		CSAPI.SetText(txt_desc, itemInfo:GetDesc());
		CSAPI.SetText(txt_useNum, tostring(useNum));
		-- if openSetting~=3 then
			local count=0;
			if (itemInfo:GetClassType()~="EquipData" and itemInfo.GetType~=nil and itemInfo:GetType()==ITEM_TYPE.EQUIP_MATERIAL) or (itemInfo:GetClassType()=="EquipData" and itemInfo.GetType~=nil and itemInfo:GetType()==EquipType.Material)  then
				local info=EquipMgr:GetEquipByCfgID(itemInfo:GetCfgID());
				count=info~=nil and info:GetCount() or 0;
			else
				count=BagMgr:GetCount(itemInfo:GetID());
			end
			CSAPI.SetText(txt_currNum, tostring(count));
		-- else
		-- 	CSAPI.SetText(txt_currNum, tostring(itemInfo:GetCount()));
		-- end
		RefreshLimit();
		CSAPI.SetGOActive(tIcon,false);
		CSAPI.SetGOActive(tBorder,false);
		if cfg then
			local showGets=true;
			if cfg.type == ITEM_TYPE.GIFT_BAG then -- 礼包
				CSAPI.SetText(txt_open, LanguageMgr:GetByID(1031))
				CSAPI.SetText(txt_openTips, LanguageMgr:GetByType(1031,4))
				CSAPI.SetGOActive(bottomObj, true);
				CSAPI.SetGOActive(btn_ok, true);
				-- CSAPI.SetGOActive(btn_comb, false);
				-- CSAPI.SetGOActive(currNumObj, true);
				SetNumObj(maxNum >1)
				-- SetBtnState(removeBtn, removeImg, false);
				-- SetBtnState(addBtn, addImg, useNum < maxNum);
				clickFunc = OpenGift;
				showGets=false;
			elseif cfg.type==ITEM_TYPE.SEL_BOX then
				CSAPI.SetText(txt_open, LanguageMgr:GetByID(1031))
				CSAPI.SetText(txt_openTips, LanguageMgr:GetByType(1031,4))
				CSAPI.SetGOActive(bottomObj, true);
				CSAPI.SetGOActive(btn_ok, true);
				-- CSAPI.SetGOActive(btn_comb, false);
				-- CSAPI.SetGOActive(currNumObj, true);
				SetNumObj(false)
				clickFunc = OpenSelBox;
				showGets=false;
			elseif cfg.is_can_use then --可以使用的道具
				CSAPI.SetText(txt_open, LanguageMgr:GetByID(1032))
				CSAPI.SetText(txt_openTips, LanguageMgr:GetByType(1032,4))
				CSAPI.SetGOActive(bottomObj, true);
				CSAPI.SetGOActive(btn_ok, true);
				-- CSAPI.SetGOActive(btn_comb, false);
				SetNumObj(maxNum > 1)
				-- SetBtnState(removeBtn, removeImg, false);
				-- SetBtnState(addBtn, addImg, useNum < maxNum);
				clickFunc = UseItem;
				showGets=false;
			-- elseif cfg.is_can_combine then --可以合成的道具
				-- CSAPI.SetGOActive(btn_comb, true);
				-- CSAPI.SetGOActive(numObj, false);
				-- CSAPI.SetGOActive(btn_ok, false);
				-- CSAPI.SetText(txt_open, StringConstant.combine)
				-- CSAPI.SetGOActive(bottomObj, true);
			elseif cfg.type == ITEM_TYPE.CARD then
				-- CSAPI.SetGOActive(currNumObj, false);
				CSAPI.SetGOActive(bottomObj, false);
				CSAPI.SetGOActive(tIcon,true);
				SetNumObj(false);
			elseif cfg.type==ITEM_TYPE.CARD_CORE_ELEM then
				CSAPI.SetGOActive(tIcon,true);
				GridUtil.LoadTIcon(tIcon,tBorder,cfg,true);
			elseif itemInfo:GetClassType()=="CharacterCardsData" then --卡牌数据类型
				CSAPI.SetGOActive(tIcon,true);
			end
			if showGets then
				--显示获取途径
				CreateGetInfo();
			else
				CSAPI.SetGOActive(chapterGet,false);
				CSAPI.SetGOActive(buildGet,false);
				CSAPI.SetGOActive(otherGet,false);
			end
		end
	end
	-- SetBgHeight();
end

function RefreshLimit()
	if itemInfo.GetExpiryTips==nil then
		CSAPI.SetGOActive(limitObj,false);
		return
	end
	local day=itemInfo:GetExpiryTips();
	CSAPI.SetGOActive(limitObj,day~=nil);
	if day then
		CSAPI.SetText(txt_limit,day);
	end
end

function SetNumObj(isShow)
	CSAPI.SetGOActive(mUseNode, isShow==true);
	if isShow then
		CSAPI.SetRTSize(svc,defaultSize[0],defaultSize[1]-282);
	else
		CSAPI.SetRTSize(svc,defaultSize[0],defaultSize[1]);
	end
end

function CreateGetInfo()
	local infos=itemInfo.GetGetWayInfo and itemInfo:GetGetWayInfo() or nil;
	local combineInfo=itemInfo.GetCombineGetInfo and itemInfo:GetCombineGetInfo() or nil;
	local jOhterInfo=itemInfo.GetJOtherGetInfo and itemInfo:GetJOtherGetInfo() or nil;
	local tOhterInfo=itemInfo.GetTOtherGetInfo and itemInfo:GetTOtherGetInfo() or nil;
	if infos==nil and combineInfo==nil and jOhterInfo==nil and tOhterInfo==nil then
		hasGet=false;
	else
		hasGet=true;
		local cIsShow,bIsShow,oIsShow=false,false,false;
		HideItems(getItems);
		HideItems(buildItems);
		HideItems(otherItems);
		HideItems(otherItems2);
		if infos and #infos>0 then
			cIsShow=true;
			CreateGetItem(infos,"GetWayItem/GoodsGetWayItemNew",getItems,chapterRoot,JumpCall);
		end
		if combineInfo and #combineInfo>0 then
			bIsShow=true;
			-- local isCombineOpen=CSAPI.IsViewOpen("MatrixCompound");
			-- local isCombineDis=isDisable;
			-- if isCombineOpen and isDisable==true then
			-- 	isCombineDis=true;
			-- end
			CreateGetItem(combineInfo,"GetWayItem/GoodsGetWayItemNew",buildItems,buildRoot,JumpCall);
		end
		if jOhterInfo and #jOhterInfo>0 then
			oIsShow=true;
			CreateGetItem(jOhterInfo,"GetWayItem/GoodsGetWayItemNew",otherItems,otherRoot,JumpCall);
		end
		if tOhterInfo and #tOhterInfo>0 then
			oIsShow=true;
			CreateGetItem(tOhterInfo,"GetWayItem/GoodsGetWayItemText",otherItems2,otherRoot);
		end
		CSAPI.SetGOActive(chapterGet,cIsShow);
		CSAPI.SetGOActive(buildGet,bIsShow);
		CSAPI.SetGOActive(otherGet,oIsShow);
	end
end

function HideItems(itemList)
	for k,v in ipairs(itemList) do
		CSAPI.SetGOActive(v.gameObject,false);
	end
end

function CreateGetItem(arr,itemPath,itemList,parent,call)
	for k,v in ipairs(arr) do
		local isDisable=false;
		if data and data.key then
			isDisable=JumpMgr.IsDisableJump(data.key,v.jumpId);
		end
		if k>#itemList then
			ResUtil:CreateUIGOAsync(itemPath,parent,function(go)
				local lua=ComUtil.GetLuaTable(go);
				lua.Refresh(v,isDisable);
				lua.SetJumpCall(call);
				table.insert(itemList,lua);
			end)
		else
			CSAPI.SetGOActive(itemList[k].gameObject,true);
			itemList[k].Refresh(v,isDisable);
		end
	end
end

function JumpCall(d)
	local cfg=Cfgs.CfgJump:GetByID(d.jumpId);
    if cfg and cfg.sName then
        local cfg2=Cfgs.view:GetByKey(cfg.sName);
		if cfg2 and cfg2.jump_close_type==1 then --跳转到窗口时关闭所有界面
			Close();--物品窗口由于多开，调用CloseAllOpenned()时不会被关闭
			CSAPI.CloseAllOpenned();
		else
			Close();
        end
		-- local isLast=CSAPI.IsLastOpenedView(cfg.sName) --是否是最后打开的全屏界面
		-- if cfg2 and cfg2.jump_close_type~=nil then --跳转到窗口时不关闭所有界面
		-- 	if not isLast then
        --     	CSAPI.CloseAllOpenned();
		-- 	else
		-- 		Close();
		-- 	end
		-- else
		-- 	Close();
        -- end
    end
end

function OpenSelBox()
	local cfg = itemInfo:GetCfg()
	if cfg == nil then
		LogError("获取配置表出错！")
		return
	end
	local rewardID = cfg.dy_value1
	local rewardCfg=Cfgs.RewardInfo:GetByID(rewardID);
	CSAPI.OpenView("GiftInfo",{info=itemInfo,rewardCfg=rewardCfg,showBtn=true});
end

--打开礼盒
function OpenGift()
	if useNum == nil then
		LogError("使用道具数量不能为nil");
		return
	end
	local cfg = itemInfo:GetCfg()
	if cfg == nil then
		LogError("获取配置表出错！")
		return
	end
	local rewardID = cfg.dy_value1
	local isEquip = GLogicCheck:CheckRewardCapacity(RandRewardType.EQUIP,
	EquipMgr.maxSize -
	EquipMgr.curSize,
	rewardID, useNum)
	local isCard = GLogicCheck:CheckRewardCapacity(RandRewardType.CARD,
	RoleMgr:GetMaxSize()-RoleMgr:GetCurSize(),rewardID, useNum)
	if isEquip == nil or isEquip == false then
		Tips.ShowTips(LanguageMgr:GetTips(12012))
		Close()
		return
	end
	if isCard == nil or isCard == false then
		Tips.ShowTips(LanguageMgr:GetTips(12013))
		Close()
		return
	end
	PlayerProto:UseItem({id = itemInfo:GetID(), cnt = useNum, arg1 = nil}, true)
	Close()
end

--使用道具
function UseItem()
	local cfg = itemInfo:GetCfg()
	if cfg and cfg.is_can_use then
		isUse=true;
		PlayerProto:UseItem({id = itemInfo:GetID(), cnt = useNum, arg1 = nil}, false, OnUseItem)
	end
end

--使用完道具的回调
function OnUseItem(proto)
	isUse=false;
	if itemInfo==nil and proto then
		local fakeData=BagMgr:GetFakeData(proto.info.id);
		Tips.ShowTips(string.format(LanguageMgr:GetTips(12014), fakeData:GetName(), proto.info.cnt))
		Close();
		return;
	end
	local goods = BagMgr:GetData(itemInfo:GetID());
	Tips.ShowTips(string.format(LanguageMgr:GetTips(12014), itemInfo:GetName(), useNum))
	if goods and goods:GetCount() > 0 then
		maxNum=itemInfo:GetCount()<g_MaxUseItem and itemInfo:GetCount() or g_MaxUseItem;
		useNum = 1;
		-- slider.value=0;
		if data then
			data.data=BagMgr:GetData(data.data:GetID());
			itemInfo=data.data;
		end
		Refresh();
		CSAPI.SetText(txt_useNum,tostring(useNum));
	else
		Close();
	end
end

--前往合成界面
function GoCombine()
	local cfg = Cfgs.CfgBCompoundOrder:GetByID(itemInfo:GetID())
	MatrixMgr:OpenCompoundPanel(cfg.id)
	Close();
end

-- function SliderCB(val)
-- 	if val == nil then
-- 		val = 0;
-- 	end
-- 	useNum = minNum + math.modf(val *(maxNum - minNum));
-- 	CSAPI.SetText(txt_num, tostring(useNum));
-- end

function OnClickReturn()
	Close();
end

--使用道具
function OnClickOpen()
	if clickFunc then
		clickFunc();
	end
end

function OnClickComb()
	GoCombine();
end

function Close()
	CSAPI.SetGOActive(tweenObj2,true);
	FuncUtil:Call(function()
		if gameObject~=nil and view~=nil then
			view:Close();
		end
	end,nil,180);
end

function OnClickBack()
	CSAPI.SetGOActive(root, true);
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
end 

function OnClickMin()
	useNum = minNum;
	-- SetBtnState(removeBtn, removeImg, useNum > 1);
	-- SetBtnState(addBtn, addImg, useNum < maxNum);
	CSAPI.SetText(txt_useNum, tostring(useNum));	
end

function OnDestroy()    
	-- CSAPI.RemoveSliderCallBack(numSlider, SliderCB);
    ReleaseCSComRefs();
end

function OnClickDetails()
	if itemInfo==nil then
		return;
	end
	local cfg = itemInfo:GetCfg();
	if cfg and cfg.type==ITEM_TYPE.PANEL_IMG and cfg.dy_value1 then--多人插图,特殊处理
		CSAPI.OpenView("MulPictureView",cfg.dy_value1);
	end
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
root=nil;
bg_b1=nil;
layout=nil;
gridNode=nil;
svc=nil;
txt_name=nil;
txt_desc=nil;
chapterGet=nil;
txt_chapterTitle=nil;
chapterRoot=nil;
buildGet=nil;
txt_buildTitle=nil;
buildRoot=nil;
otherGet=nil;
txt_otherTitle=nil;
otherRoot=nil;
currNumObj=nil;
txt_has=nil;
txt_currNum=nil;
view=nil;
end
----#End#----