--勘探系统购买等级
local data=nil;
local upLv=nil;
local nextLv=nil;
local maxLv=nil;
local currLv=nil;
local costID=nil;
local currPrice=0;
local eventMgr=nil;;
local layout=nil;
function Awake()
	layout=ComUtil.GetCom(hsv,"UISV");
	layout:Init("UIs/Grid/GridItem",LayoutCallBack,true,0.8)
	eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Exploration_Upgrade_Ret,OnClickMask)
end

function OnDestroy()
	eventMgr:ClearListener();
end

function OnOpen()
    --初始化等级
    data=ExplorationMgr:GetCurrData();
	Refresh();
end

function Refresh()
    CSAPI.SetText(txt_stage1,tostring(data:GetCurrLv()));
    nextLv=data:GetNextLv();
	currLv=data:GetCurrLv();
	maxLv=data:GetMaxLv()-currLv;
    upLv=1;
	local str=tostring(math.floor(upLv));
    CSAPI.SetText(txt_num, str);
    RefreshNextStage();
    --刷新奖励列表
    RefreshRewards();
    RefreshPrice();
end

function RefreshRewards()
	local tLv=currLv+math.floor(upLv);
	local baseList=data:GetBaseRewardCfgs(tLv);
	local plusList={};
	if data:GetState()>ExplorationState.Normal then
		plusList=data:GetExRewardCfgs(tLv);
	end
	curData={};
	local rewards={};
	for i=1,#baseList do --统计归类
		local rs=baseList[i]:GetRewardData();
		for k, v in ipairs(rs) do
			if rewards[v.id]~=nil then
				rewards[v.id].num=rewards[v.id].num+v.num;
			else	
				rewards[v.id]=v;
			end
		end
		
		if plusList and #plusList>=i then
			local rewards2=plusList[i]:GetRewardData();
			for k, v in ipairs(rewards2) do
				if rewards[v.id]~=nil then
					rewards[v.id].num=rewards[v.id].num+v.num;
				else	
					rewards[v.id]=v;
				end
			end
		end
	end
	for k,v in pairs(rewards) do
		local gData=GridUtil.RandRewardConvertToGridObjectData(v);
		table.insert(curData,gData);
	end
	layout:IEShowList(#curData);
end

function LayoutCallBack(index)
	local item=layout:GetItemLua(index);
	item.Refresh(curData[index])
	item.SetClickCB(GridClickFunc.OpenNotGet)
end

function RefreshPrice()
    --获得升级所需消耗
    local cfgs=data:GetUpExpCfgs(currLv+upLv-1);
    if cfgs then
        local id=nil;
        local num=0;
        id=cfgs[1].cost[1][1]
        for k,v in ipairs(cfgs) do
            num=num+v.cost[1][2];
        end
		costID=id;
		currPrice=num;
        SetPrice(id, num);
    end
end

function SetPrice(id, num)
	if id == ITEM_ID.GOLD then --钻石
		ResUtil.IconGoods:Load(moneyIcon, tostring(ITEM_ID.GOLD).."_1");
		ResUtil.IconGoods:Load(coinIcon, tostring(ITEM_ID.GOLD).."_1");
	elseif id == ITEM_ID.DIAMOND then --金币
		ResUtil.IconGoods:Load(moneyIcon, tostring(ITEM_ID.DIAMOND).."_1");
		ResUtil.IconGoods:Load(coinIcon, tostring(ITEM_ID.DIAMOND).."_1");
	else
		local cfg = Cfgs.ItemInfo:GetByID(id);
		if cfg and cfg.icon then
			ResUtil.IconGoods:Load(moneyIcon, cfg.icon.."_1");
		end
	end
	CSAPI.SetText(txt_price, tostring(math.floor(num+0.5)));
	--设置货币持有数
	CSAPI.SetScale(coinIcon,1,1,1);
	local num=BagMgr:GetCount(id);
	if (num >= 100000) then
        CSAPI.SetText(txt_hasNum, math.floor(num / 10000) .. "W")
    else
        CSAPI.SetText(txt_hasNum, tostring( num))
    end
end

function RefreshNextStage()
	local str=tostring(currLv+math.floor(upLv));
    CSAPI.SetText(txt_stage2,str);
	local tips=LanguageMgr:GetTips(22001,str);
	CSAPI.SetText(txt_tips,tips);
    -- CSAPI.SetText(txt_tips,string.format("提升至%s阶段，可获得以下奖励",str));
end

function SetBtnState(btn,img, enable)
	if btn then
		if enable then
			btn.enabled = enable;
		else
			btn.enabled = false;
		end
	end
end 

function OnClickAdd()
	if upLv < maxLv then
		upLv = upLv + 1;
		CSAPI.SetText(txt_num,tostring(math.floor(upLv)));		
	end
	SetBtnState(removeBtn,removeImg, upLv > 1);
	SetBtnState(addBtn,addImg, upLv < maxLv);
	SetBtnState(maxBtn,maxImg, upLv < maxLv);
	RefreshPrice();
	RefreshRewards();
	RefreshNextStage()
end

function OnClickRemove()
	if upLv > 1 then
		upLv = upLv - 1;
		CSAPI.SetText(txt_num, tostring(math.floor(upLv)));	
	end
	local tempLv=currLv+upLv;
	SetBtnState(removeBtn,removeImg, tempLv > nextLv);
	SetBtnState(addBtn,addImg, tempLv<maxLv);
	SetBtnState(maxBtn,maxImg, tempLv<maxLv);
	RefreshPrice();
	RefreshRewards();
	RefreshNextStage()
end

function OnClickMax()
	upLv=maxLv;
	SetBtnState(removeBtn,removeImg, upLv > nextLv);
	SetBtnState(addBtn,addImg, false);
	SetBtnState(maxBtn,maxImg, false);
	CSAPI.SetText(txt_num, tostring(math.floor(upLv)));	
	RefreshPrice();
	RefreshRewards();
	RefreshNextStage()
end

function OnClickMin()
	upLv=1;
	local tempLv=currLv+upLv;
	SetBtnState(removeBtn,removeImg, currLv > nextLv);
	SetBtnState(addBtn,addImg, currLv<maxLv);
	SetBtnState(maxBtn,maxImg, currLv<maxLv);
	SetBtnState(minBtn,minImg, false);
	CSAPI.SetText(txt_num, tostring(math.floor(upLv)));	
	RefreshPrice();
	RefreshRewards();
	RefreshNextStage()
end

function OnClickPay()
    --发送购买协议
	local canPay=false;
	if costID== ITEM_ID.GOLD or costID==ITEM_ID.DIAMOND or costID==g_AbilityCoinId or costID==g_ArmyCoinId then
		canPay=PlayerClient:GetCoin(costID)>=currPrice;
	elseif costID == - 1 then
		canPay=true;
		--进入SDK支付流程
		return;
	else
		local count=BagMgr:GetCount(costID);
		canPay=count>=currPrice;
	end
	if canPay then
		--提示是否购买
		local dialogdata = {
			content = LanguageMgr:GetByID(18312,currPrice),
			okCallBack = function()
				if CSAPI.IsADVRegional(3)  and costID==ITEM_ID.DIAMOND then
					CSAPI.ADVJPTitle(currPrice,function()   ExplorationProto:Upgrade(data:GetCfgID(),currLv+math.floor(upLv)); end)
				else
					ExplorationProto:Upgrade(data:GetCfgID(),currLv+math.floor(upLv));
				end
			end
		}
		CSAPI.OpenView("Dialog", dialogdata);
	else
		local goods=GoodsData();
        goods:InitCfg(costID);
		Tips.ShowTips(string.format(LanguageMgr:GetTips(15000),goods:GetName()));
	end
end

function OnClickMask()
	view:Close();
end