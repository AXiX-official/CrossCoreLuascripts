local ids={ ITEM_ID.GOLD,ITEM_ID.DIAMOND};--金币ID
local eventMgr=nil;
local video=nil;
local layout=nil;
local layout1Tween=nil;
local layout2=nil;
local layout2Tween=nil;
local layout3=nil;
local layout3Tween=nil;
local layout4=nil;
local layout4Tween=nil;
local layout5=nil;
local layout5Tween=nil;
local pages=nil;
local currPageIndex=nil; --当前选中的页签下标
local headTabs={};--头部页签
local currPageData=nil;
local lastPageIndex=nil;--最后显示的页签下标
local isPlayTween=false;
local topTools=nil;
local shopID=nil;--商店ID
local isHideMonthPay=false;
local countTime=0;
local lastTime=0;
local updateTime=1;
local f_tTime=0.66;--首次循环动画播放时间
local s_tTime={0.22,0.22};--单次动画播放时间
local l_tTime=3;--间隔播放时间
local t_index=0;
local t_countTime=0;--动画计时器
local isPlaying=false;
local isFirstTween=true;
local isNil=false;
local isTweenning=false;--是否正在播放列表动画
local isFirst=true;
local currLayout=nil;
local currTween=nil;
local childTabDatas=nil;--二级子菜单数据
local childTabItems={};--二级子菜单子物体
local childPageID=nil;--当前选中的二级页签下标
local currChildPage=nil;--当前子页面配置信息
local monthCardItems={};
local newInfos=nil;--new状态数据
local lastChildPageIDs=nil;--当前页面的二级页签的id列表
local lastPageIDs=nil;--当前商店的页面id列表
local layout6=nil;
local FirstEnterQuestionItem=false;
function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Shop_Tab_Change,OnPageChange)
    eventMgr:AddListener(EventType.Shop_TopTab_Change,OnChildTabChange)
    -- eventMgr:AddListener(EventType.Shop_MemberCard_Ret,OnMemberCardRet)
    eventMgr:AddListener(EventType.Shop_RandComm_Refresh,OnRandCommRefresh)
    eventMgr:AddListener(EventType.Shop_RecordInfos_Refresh,OnShopInfosRefresh)
    eventMgr:AddListener(EventType.Shop_Jump_Refresh,OnJumpRefresh)
    eventMgr:AddListener(EventType.Card_Skin_Get, OnSkinGet)
    eventMgr:AddListener(EventType.Shop_View_Refresh,Refresh)
    eventMgr:AddListener(EventType.Shop_Buy_Ret,OnBuyRet)
    eventMgr:AddListener(EventType.Shop_Exchange_Ret,OnExchangeRet)
    eventMgr:AddListener(EventType.Shop_NewInfo_Refresh,SetNewInfo)
    eventMgr:AddListener(EventType.Shop_ResetTime_Ret,InitRefreshInfo)
    eventMgr:AddListener(EventType.Shop_OpenTime_Ret,OnShopTagRefresh)
    InitSVList();
    --商店bgm
    local bgm = g_bgm_shop;
    if(bgm)then
        CSAPI.PlayBGM(bgm);
    end
    video = ResUtil:PlayVideo("monthcard");
    CSAPI.SetParent(video.gameObject, videoNode);
    ClientProto:GetMemberRewardInfo();
    ShopProto:GetShopResetTime();
    MenuBuyMgr:ConditionCheck(2,"shopOpen") --MenuMgr:ShopFirstOpen() --商店第一次打开记录 rui
    UIUtil.SetRTAlpha(rtCamera,sv5Img);
    -- CSAPI.SetRenderTexture(sv5Img,goRT);
	-- CSAPI.SetCameraRenderTarget(rtCamera,goRT);
end
function OnAddQuestionItem()
    FirstEnterQuestionItem=true;
    RefreshDeductionBouchers()
    SetDeductionBouchersIcon()
end
--页签刷新
function OnShopTagRefresh()
    if CSAPI.IsViewOpen("DormThemePayView") then
        CSAPI.CloseView("DormThemePayView");
    end
    if CSAPI.IsViewOpen("DormFurniturePayView") then
        CSAPI.CloseView("DormFurniturePayView");
    end
    --获取新的page页信息
    pages=nil;
    lastPageIndex=nil;
    currPageIndex=nil;
    childPageID=nil;
    currPageData=nil;
    currChildPage=nil;
    if data then
        pages={ShopMgr:GetPageByID(data)};
    else
        pages=ShopMgr:GetAllPages(true);
    end
    if pages==nil or next(pages)==nil then
        --不存在页签则关闭页面
        --弹提示
        Tips.ShowTips(LanguageMgr:GetTips(15121));
        OnClickBack()
        do return end
    end
    RecordPageIDs();
    Tips.ShowTips(LanguageMgr:GetTips(15120));
    --刷新商店页面
    local index=1;
    for k,v in ipairs(pages) do
        if v:IsDefaultOpen() then
            index=k;
        elseif k==1 then
            index=k;
            break;
        end
    end
    currPageIndex=index;
    childPageID=nil;
    Refresh();
end

--初始化无限滚动列表
function InitSVList()
    layout = ComUtil.GetCom(sv, "UISV")
    layout:Init("UIs/Shop/CommodityItem",LayoutCallBack,true)
    layout1Tween=UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.MoveByType2,{"RTL"});
    layout2 = ComUtil.GetCom(sv2, "UISV")
	layout2:Init("UIs/Shop/VCommodityItem",LayoutCallBack2,true)
    layout2Tween=UIInfiniteUtil:AddUIInfiniteAnim(layout2, UIInfiniteAnimType.MoveByType2,{"RTL"});
    layout3 = ComUtil.GetCom(sv3, "UISV")
	layout3:Init("UIs/Shop/PayCommodityItem",LayoutCallBack3,true)
    layout3Tween=UIInfiniteUtil:AddUIInfiniteAnim(layout3, UIInfiniteAnimType.MoveByType2,{"RTL"});
    layout4 = ComUtil.GetCom(sv4, "UISV")
    layout4:Init("UIs/Shop/CommodityItem",LayoutCallBack4,true)
    layout4Tween=UIInfiniteUtil:AddUIInfiniteAnim(layout4, UIInfiniteAnimType.MoveByType2,{"RTL"});
    layout5 = ComUtil.GetCom(sv5, "UISV")
	layout5:Init("UIs/Shop/SkinCommodityItem",LayoutCallBack5,true)
    layout5Tween=UIInfiniteUtil:AddUIInfiniteAnim(layout5, UIInfiniteAnimType.MoveByType2,{"RTL"});
    layout6 = ComUtil.GetCom(leftsv, "UISV")
	layout6:Init("UIs/Shop/ShopTabItem",LayoutCallBack6,true)
end

function OnInit()
    topTools=UIUtil:AddTop2("ShopView",gameObject,OnClickBack,nil,ids);
end

function OnDestroy()
    ShopMgr:SetJumpVoucherID();
    eventMgr:ClearListener();
    RoleAudioPlayMgr:StopSound();
    EventMgr.Dispatch(EventType.Replay_BGM);--重播场景背景音乐
    ReleaseCSComRefs();
    UIUtil.DestoryRT();
end

--data:传入商店页ID，只显示单个商店 openSetting={商店一级页面ID，商店二级页签ID}
function OnOpen()
    pages=nil;
    if data then
        pages={ShopMgr:GetPageByID(data)};
    else
        pages=ShopMgr:GetAllPages(true);
    end
    if pages==nil or next(pages)==nil then
        LogError("未找到商店页面数据！");
        do return end
    end
    RecordPageIDs();
    -- ShopMgr:CheckCommReset(); --检测一次商店的新商品
    local index=1;
    for k,v in ipairs(pages) do
        if openSetting then
            if v:GetID()==openSetting[1] then
                index=k;
                break;
            end
        else
            if v:IsDefaultOpen() then
                index=k;
            elseif k==1 then
                index=k;
                break;
            end
        end
    end
    local tempCID=openSetting and openSetting[2] or nil;
    if currPageIndex==index and childPageID==tempCID and isFirst~=true then
        do return end;
    end
    currPageIndex=index;
    childPageID=tempCID;
    -- lastPageIndex=currPageIndex;
    if openSetting then
        Refresh(true);
    else
        Refresh()
    end
    if openSetting and openSetting[3]~=nil and openSetting[3]~="" then
        ShopCommFunc.OpenBuyConfrim(openSetting[1],openSetting[2],tonumber(openSetting[3]));
    end
    isFirst=false;
end

function Refresh(isJump)
    currPageData=pages[currPageIndex];
    childTabDatas=currPageData:GetTopTabs(true);
    RecordChildPageIDs();
    --查找默认子页面
    if childTabDatas and next(childTabDatas) and currPageData:GetCommodityType()~=CommodityType.Promote  then
        if not isJump then
            childPageID=lastPageIndex==currPageIndex and childPageID or childTabDatas[1].id;
        else
            childPageID=childPageID or childTabDatas[1].id;
        end
        for k,v in ipairs(childTabDatas) do
            if childPageID==v.id then
                currChildPage=v;
                break;
            end
        end
    else
        childTabDatas=nil;
        childPageID=nil;
        currChildPage=nil;
    end
    if currPageData and childPageID and currChildPage and newInfos and newInfos[currPageData:GetID()] and newInfos[currPageData:GetID()][childPageID] and currChildPage.tips then
        Tips.ShowTips(LanguageMgr:GetTips(currChildPage.tips));   --抛出刷新提示
    elseif currPageData and childPageID==nil and newInfos and newInfos[currPageData:GetID()] then
        --判断是否还有其它数据
        if currPageData:GetTips() then
            Tips.ShowTips(LanguageMgr:GetTips(currPageData:GetTips()));   --抛出刷新提示
        end
        if currPageData:GetID()==4 then--皮肤商店
            ShopMgr:SetSkinStoreNewState();--设置皮肤状态
        end
    end
    ShopMgr:SetCommResetInfo(currPageData:GetID(),childPageID);
    ShopMgr:CheckCommReset();--检测一次商店的新商品
    InitHeadTabs();
    InitLeftTabs(isJump);
    isPlayTween=lastPageIndex~=currPageIndex;
    if currPageData:GetCommodityType()==CommodityType.Rand then
        local exchangeCfg=Cfgs.CfgRandCommodity:GetGroup(currPageData:GetID())[1];
        if exchangeCfg then
            shopID=exchangeCfg.id;
        end
    else
        shopID=currPageData:GetID();
    end
    local goldInfo={}
    if currChildPage and currChildPage.goldInfo then --优先显示子页面的货币信息
        goldInfo=currChildPage.goldInfo;
    else
        goldInfo=currPageData:GetGoldType();
    end
    OnMoneyChange(goldInfo);
    CSAPI.SetGOActive(btnExchange,IsShowExchange());
    QuestionItemSetActive(false)
    if currPageData:GetCommodityType()==CommodityType.Promote then--推荐页
        InitPromotes();
    else
        InitSV();
    end
    if isPlayTween then
        --播放动画
        PlayTween();
        lastPageIndex=currPageIndex;
    end
    InitRefreshInfo();
end

--播放动画
function PlayTween()
    if currPageData==nil then
        return
    end
    if  currPageData:GetCommodityType()==CommodityType.Rand then --随机道具才有刷新信息
        -- SetArrActive({topTweenObj,refreshTweenObj,bottomTweenObj},false);
        -- SetArrActive({topTweenObj,refreshTweenObj},true);
        CSAPI.PlayUISound("ui_popup_open")
	elseif currPageData:GetShowType()==ShopShowType.MonthCard then --月卡
        CSAPI.PlayUISound("ui_infolineeject_in_2")
    else
        -- SetArrActive({topTweenObj,refreshTweenObj,bottomTweenObj},false);
		-- SetArrActive({topTweenObj,bottomTweenObj},true);
        CSAPI.PlayUISound("ui_popup_open")
	end
    -- CSAPI.SetGOActive(mask,true);
    -- --动画时添加遮罩
    -- FuncUtil:Call(function()
    --     CSAPI.SetGOActive(mask,false);
    -- end,nil,520);
end

--初始化头部页签
function InitHeadTabs()
    if headTabs==nil or #headTabs==0 or (pages~=nil and #pages~=#headTabs) then
        ItemUtil.AddItems("Shop/ShopHeadTabItem", headTabs, pages, headNode, nil, 1, {sIndex=currPageIndex,newInfos=newInfos,childPageID=childPageID});
    else
        for k, v in ipairs(headTabs) do
            v.SetNewInfo(newInfos)
            if v.index==currPageIndex then
                v.PlayTween(true);
            elseif v.index==lastPageIndex then
                v.PlayTween(false);
            else
                v.PlayTween(false);
            end
        end
    end
end 

--初始化左边二级菜单
function InitLeftTabs(isJump)
    -- childTabDatas=currPageData:GetTopTabs(true);
    if childTabDatas and next(childTabDatas) and currPageData:GetCommodityType()~=CommodityType.Promote  then
    --     if not isJump then
    --         childPageID=lastPageIndex==currPageIndex and childPageID or childTabDatas[1].id;
    --     else
    --         childPageID=childPageID or childTabDatas[1].id;
    --     end
    --     for k,v in ipairs(childTabDatas) do
    --         if childPageID==v.id then
    --             currChildPage=v;
    --             break;
    --         end
    --     end
     --   ItemUtil.AddItems("Shop/ShopTabItem", childTabItems, childTabDatas, leftParent, nil, 1, {sID=childPageID,pageID=currPageData:GetID(),newInfos=newInfos});
        CSAPI.SetGOActive(leftParent,true);
        layout6:IEShowList(#childTabDatas);
    -- else
    --     childTabDatas=nil;
    --     childPageID=nil;
    --     currChildPage=nil;
    else
        CSAPI.SetGOActive(leftParent,false);
    end
end

function InitPromotes()
    SetArrActive({cardPage,sv,sv2,sv3,sv4,sv5,bMask,leftParent,videoNode,btnSkinSet},false);
    CSAPI.SetAnchor(promoteObj,0,0);
    if promoteItem==nil then
        ResUtil:CreateUIGOAsync("ShopPromote/PromoteMain",promoteObj,function(go)
            local lua=ComUtil.GetLuaTable(go);
            lua.Refresh();
            promoteItem=lua;
        end);
    else
        promoteItem.Refresh();        
    end
    --初始化看板
    -- if info:GetCRoleID() and info:GetModelID() and info:GetVoiceType() then
    --     cRoleItem.Refresh(info:GetCRoleID(), info:GetModelID(), LoadImgType.Shop,nil , true)
    --     -- function()
    --     --     LogError("点击物体！");
    --     --     cRoleItem.PlayVoice(info:GetVoiceType());
    --     -- end
    --     local cfg = Cfgs.CfgCardRole:GetByID(info:GetCRoleID())
    --     CSAPI.SetText(txtTalkName, cfg and cfg.sAliasName or "")  
    --     FuncUtil:Call(function()
    --         cRoleItem.PlayVoice(info:GetVoiceType());
    --     end,nil,100)
    -- end
end

--获取随机兑换道具并刷新页面
function SetRandCommodity(isRefresh,isTimeOut)
    local list=ShopMgr:GetExchangeData(shopID);
    if  isTimeOut then
        lastTime=ShopMgr:GetExchangeRefreshTime(shopID);
    end
    if list==nil or isRefresh or isTimeOut then
        ShopProto:GetExchangeInfo(shopID,isRefresh);
    else
        OnRandCommRefresh();
    end
end

function OnRandCommRefresh()
    if currPageData~=nil and currPageData:GetCommodityType()==CommodityType.Rand then --回调没切换页面的话则刷新
        curDatas=currPageData:GetCommodityInfos(true);
        table.sort(curDatas,ShopCommFunc.SortRandComm);
        currLayout:IEShowList(#curDatas,OnAnimeEnd);
        SetSVActive();
        InitRefreshInfo();
    end
end

function SetArrActive(arr,isActive)
    if arr and #arr>=1 then
        for k,v in ipairs(arr) do
            CSAPI.SetGOActive(v,isActive);
        end
    end
end

function SetSVActive()
    if currLayout==nil then
        return;
    end
    local isActive=true;
    local size=CSAPI.GetRTSize(currLayout:GetSR().content.gameObject);
    local size2=CSAPI.GetRTSize(currLayout.gameObject);
    -- Log(size[0].."\t"..size2[0].."\t"..size[1].."\t"..size2[1])
    if currLayout:GetIsVertical()==1 then
        isActive=size[1]>size2[1]
    else
        isActive=size[0]>size2[0]
    end
    -- Log(tostring(isActive))
    currLayout:SetSRActive(isActive);
end

--donReset:不重置
function InitSV(donReset)
    SetLayout();
    if currLayout then
        if currPageData:GetCommodityType()==CommodityType.Rand and ShopMgr:GetExchangeData(currPageData:GetID())==nil then
            --获取随机兑换道具页面数据
            SetRandCommodity(false,true);
        else
            curDatas=currPageData:GetCommodityInfos(true,childPageID);
            if currPageData:GetShowType()==ShopShowType.Skin then--皮肤排序
                table.sort(curDatas,ShopCommFunc.SortSkinComm);
                -- curDatas={};
                isNil=#curDatas<=0;
                CSAPI.SetGOActive(nilObj,isNil)
            else--固定商品排序
                table.sort(curDatas,ShopCommFunc.SortComm)
            end
            if ShopCommFunc.IsRecordRefreshInfo(currPageData:GetID()) then --记录一次当前列表刷新时间
                local nowTime=TimeUtil:GetTime();
                local childID=currChildPage and currChildPage.id or nil;
                local checkList=currPageData:GetRefreshInfos(childID);
                ShopCommFunc.IsRefreshCommodityInfos(checkList,nowTime);
            end
            if donReset then
                isTweenning=false;
                CSAPI.SetGOActive(mask,isTweenning);
                -- currLayout:UpdateList();
                currLayout:IEShowList(#curDatas);
                SetSVActive();
            else
                currLayout:IEShowList(#curDatas,OnAnimeEnd);
                SetSVActive();
            end
        end
    else
        -- if isHideMonthPay then
            CSAPI.SetGOActive(btn_pay,false);
            CSAPI.SetText(txt_cardTips,LanguageMgr:GetTips(15103))
        -- else ---旧的月卡逻辑，现在不需要了
        --     CSAPI.SetText(txt_cardTips,LanguageMgr:GetByID(18010))
        --     local info=ShopMgr:GetMonthCardInfo(ItemMemberType.Month);
        --     if info and info.l_cnt>5 then
        --         CSAPI.SetGOActive(btn_pay,false);
        --         CSAPI.SetGOActive(monthOverObj,true)
        --     else
        --         CSAPI.SetGOActive(btn_pay,true);
        --         CSAPI.SetGOActive(monthOverObj,false)
        --     end
        -- end
    end
end

function OnAnimeEnd()
    isTweenning=false;
    CSAPI.SetGOActive(mask,isTweenning);
end

--商店内部跳转
function OnJumpRefresh(eventData)
    if eventData then
        local index=1;
        for k,v in ipairs(pages) do
            if eventData and v:GetID()==eventData.pageID then
                index=k;
                break;
            end
        end
        lastPageIndex=currPageIndex;
        currPageIndex=index;
        childPageID=eventData.childID or nil;
        Refresh(true);
    end
end

function OnMoneyChange(infos)
    --topTools.SetMoney(goldId or {});
    if CSAPI.IsADV() then
        local  tableinfo={};
        if infos then
            for i, v in pairs(infos) do
                if tostring(infos[i][1])==tostring(10999) then
                    if  BagMgr:GetCount(10999)==0 then
                        --table.remove(infos,i)
                    else
                        table.insert(tableinfo,infos[i]);
                    end
                else
                    table.insert(tableinfo,infos[i]);
                end
            end
        end
        topTools.SetMoney(tableinfo and tableinfo or nil);   -- 需要加跳转id todo
    else
        topTools.SetMoney(infos and infos or nil);   -- 需要加跳转id todo
    end
end

function IsShowExchange()
    local isFragment=currPageData:ShowExchange();
    if currChildPage then --优先显示子页面的碎片兑换
        return currChildPage.fragmentExchange==1;
    else
        return currPageData:ShowExchange();
    end
end

function LayoutCallBack(index)
	local _data = curDatas[index]
    local item=layout:GetItemLua(index);
    item.Refresh(_data,{commodityType=currPageData:GetCommodityType()});
    item.SetClickCB(OnClickGrid);
end

function LayoutCallBack2(index)
    local _data=curDatas[index]
    local item=layout2:GetItemLua(index);
    item.Refresh(_data,{commodityType=currPageData:GetCommodityType(),showType=currPageData:GetShowType()});
    item.SetClickCB(OnClickPackage);
end

function LayoutCallBack3(index)
    local _data=curDatas[index]
    local item=layout3:GetItemLua(index);
    item.Refresh(_data,{commodityType=currPageData:GetCommodityType()});
    item.SetClickCB(OnClickGrid);
end

function LayoutCallBack4(index)
	local _data = curDatas[index]
    local item=layout4:GetItemLua(index);
    -- item.Refresh(_data,{commodityType=currPageData:GetCommodityType(),showType=currPageData:GetShowType()});
    item.Refresh(_data,{commodityType=currPageData:GetCommodityType(),showType=currPageData:GetShowType()});
    item.SetClickCB(OnClickGrid);
end

function LayoutCallBack5(index)
    local _data=curDatas[index]
    local item=layout5:GetItemLua(index);
    item.Refresh(_data);
    item.SetIndex(index);
    item.SetClickCB(OnClickSkin);
end

function LayoutCallBack6(index)
    local _data=childTabDatas[index]
    local item=layout6:GetItemLua(index);
    local elseData={sID=childPageID,pageID=currPageData:GetID(),newInfos=newInfos}
    item.Refresh(_data, elseData);
    -- item.SetIndex(index);
    -- item.SetClickCB(OnClickSkin);
end


--购买月卡
--[[ 旧的购买月卡逻辑，现在不需要
function OnClickPay()
    local items=currPageData:GetCommodityInfos(true);
    local info=ShopMgr:GetMonthCardInfo(ItemMemberType.Month);
    if (items and #items>=1)  then
        local isForce=info and info.l_cnt<=5 or false;
        ShopCommFunc.OpenPayView(items[1],currPageData,function()
            ClientProto:GetMemberRewardInfo();
            Refresh();
        end,isForce);
    end
end

function OnMemberCardRet()
    local info=ShopMgr:GetMonthCardInfo(ItemMemberType.Month);
    if info and info.l_cnt>5 then
        CSAPI.SetGOActive(btn_pay,false);
        CSAPI.SetGOActive(monthOverObj,true)
    else
        CSAPI.SetGOActive(btn_pay,true);
        CSAPI.SetGOActive(monthOverObj,false)
    end
end
--]]

function OnClickSkin(tab)
    --显示皮肤预览界面
    local nowIdx=1; --当前选中的下标
    if tab then
        nowIdx=tab.GetIndex();
    end
    local list={};
    for k,v in ipairs(curDatas) do
        table.insert(list,ShopCommFunc.GetSkinInfo(v));
    end
    CSAPI.OpenView("SkinFullInfo",{list=list,idx=nowIdx})
end

function OnShopInfosRefresh()
    -- LogError("OnShopInfosRefresh-------------------")
    InitSV();
end

--检测自动刷新时间
function AutoRefresh()
	if currPageData~=nil and currPageData:GetCommodityType()==CommodityType.Normal then--检测固定道具商店的重置时间和折扣时间
		local nowTime=TimeUtil:GetTime();
        local childID=currChildPage and currChildPage.id or nil;
		local checkList=currPageData:GetRefreshInfos(childID);
		local isReset,isRefresh=ShopCommFunc.IsRefreshCommodityInfos(checkList,nowTime);
        -- LogError("isReset:"..tostring(isReset).."\t isRefresh:"..tostring(isRefresh))
        -- if lastTime~=0 and lastTime-1<=0 then
        --     ShopProto:GetShopResetTime();
		-- end
		if isReset then --列表刷新
            ShopMgr:CheckCommReset();
            ShopProto:GetShopCommodity(currPageData:GetID());
            -- local groupID=currChildPage and currChildPage.id or nil;
	        -- ShopProto:GetShopCommodity(currPageData:GetID(),groupID);
            -- ShopProto:GetShopInfos()
            -- ShopProto:GetShopResetTime();
			return
        elseif isRefresh and currLayout then --道具购买期限刷新    
            ShopMgr:CheckCommReset();
            local isDonReset=true;
            if currPageData:GetShowType()==ShopShowType.Skin then
                isDonReset=false;
            end
            -- LogError("道具购买期限刷新！"..tostring(isDonReset))
            InitSV(isDonReset);
            -- currLayout:UpdateList();
            -- ShopProto:GetShopResetTime();
        end
	end
    if lastTime and lastTime>0 and currPageData~=nil then 
		lastTime=lastTime-updateTime;
		if lastTime<=0 then
			-- Log( "自动刷新");
			lastTime=0;
            if currPageData:GetCommodityType()==CommodityType.Rand then--随机道具商店刷新
                SetRandCommodity(false,true);
            end
		end
		SetTimeText(lastTime)
	end
end

function Update()
    countTime=countTime+Time.deltaTime;
	if countTime>=updateTime then
		AutoRefresh();
        CheckPageRefresh();
		countTime=0;
	end
    if isNil==true then
        LoopTween();
    end
end

--获得皮肤时，刷新列表
function OnSkinGet()
    if currPageData and currPageData:GetShowType()==ShopShowType.Skin then
        InitSV();
    end
end

--初始化刷新信息
function InitRefreshInfo()
	if currPageData~=nil and currPageData:GetCommodityType()==CommodityType.Rand then --随机道具才有刷新信息
        local canRefresh=ShopMgr:GetExChangeCanRefresh(shopID);
        CSAPI.SetGOActive(btnRefresh,canRefresh);
        CSAPI.SetGOActive(txt_refreshTime2,false);
		CSAPI.SetGOActive(refreshObj,true);
		--设置计时器
		lastTime=ShopMgr:GetExchangeRefreshTime(shopID);
        lastTime=lastTime or 0;
		SetTimeText(lastTime);
    elseif (currPageData~=nil and currPageData:GetUpdateTime()~=ShopFixedUpdateType.None) or (
        currChildPage~=nil and currChildPage.updateTime~=nil and currChildPage.updateTime~=ShopFixedUpdateType.None
    ) then --固定商店刷新时间
        local updataType=currPageData:GetUpdateTime()
        -- LogError(currPageData:GetID())
        if currChildPage then
            updataType=currChildPage.updateTime
            -- LogError(currChildPage)
        end
        local lTime=ShopMgr:GetFixedUpdateTime(updataType);
        lastTime=lTime>TimeUtil:GetTime() and lTime-TimeUtil:GetTime() or 0; --计算剩余时间
        -- LogError(tostring(lTime).."\t"..tostring(lastTime));
        SetTimeText(lastTime);
        CSAPI.SetGOActive(refreshObj,false);
        CSAPI.SetGOActive(txt_refreshTime2,true);
    else
		CSAPI.SetGOActive(refreshObj,false);
        CSAPI.SetGOActive(txt_refreshTime2,false);
	end
end

function SetTimeText(time)
    -- time= 124000;
    local timeStr="";
    local txt=txt_refreshTime;
    if currPageData~=nil and currPageData:GetCommodityType()~=CommodityType.Rand then 
        txt=txt_refreshTime2;
    end
    if time>=86400 then
        local nowTime=TimeUtil:GetTime();
        local count=TimeUtil:GetDiffHMS(time+nowTime,nowTime);
        timeStr=string.format(LanguageMgr:GetByID(34017),count.day,count.hour>=10 and count.hour or "0"..count.hour,count.minute>=10 and count.minute or "0"..count.minute,count.second>=10 and count.second or "0"..count.second)
    else
        timeStr=TimeUtil:GetTimeStr(time);
    end
	CSAPI.SetText(txt,timeStr);
end

function SetLayout()
    QuestionItemSetActive(false)
    local isShowSet=false;
    local hasTabs=childTabDatas~=nil and #childTabDatas>1 or false;--当前页面是否有二级菜单
    if currPageData:GetCommodityType()==CommodityType.Promote then--推荐页
        do return end--推荐页不做任何处理
    elseif currPageData:GetShowType()==ShopShowType.Normal then      
        currLayout=hasTabs==true and layout4 or layout;
        currTween=hasTabs==true and layout4Tween or layout1Tween;
    elseif currPageData:GetShowType()==ShopShowType.Package then
        QuestionItemSetActive(true)
        currLayout=layout2;
        currTween=layout2Tween;
    elseif currPageData:GetShowType()==ShopShowType.Card then
        currLayout=layout2;
        currTween=layout2Tween;
    elseif currPageData:GetShowType()==ShopShowType.Pay then --充值
        QuestionItemSetActive(true)
        currLayout=layout3;
        currTween=layout3Tween;
    elseif currPageData:GetShowType()==ShopShowType.Skin then--皮肤
        currLayout=layout5;
        currTween=layout5Tween;
        if CSAPI.IsAppReview() then
            isShowSet=false;
        else
            isShowSet=true;
        end
    elseif currPageData:GetShowType()==ShopShowType.MonthCard then
        currLayout=nil;
        if isHideMonthPay then
            CreateMonthItemsTest();
        else
            CreateMonthItems(); --暂时注释，测试包不需要显示物品
        end
        currTween=nil;
    end
    CSAPI.SetGOActive(btnSkinSet,isShowSet);
    CSAPI.SetGOActive(sv,currLayout==layout);
    CSAPI.SetGOActive(sv2,currLayout==layout2);
    CSAPI.SetGOActive(sv3,currLayout==layout3);
    CSAPI.SetGOActive(sv4,currLayout==layout4);
    CSAPI.SetGOActive(sv5,currLayout==layout5);
    CSAPI.SetGOActive(cardPage,currLayout==nil);
    CSAPI.SetGOActive(videoNode,currLayout==nil);
    CSAPI.SetGOActive(bMask,true);
    -- SetArrActive({promoteObj,talkBg},false);
    --临时用
    SetArrActive({talkBg},false); 
    CSAPI.SetAnchor(promoteObj,0,10000);
    RoleAudioPlayMgr:StopSound();--中断语音
    if isPlayTween and currTween~=nil and isTweenning~=true then
        isTweenning=true;
        CSAPI.SetGOActive(mask,isTweenning);
        currTween:AnimAgain();
    end
end

---设置抵扣券 介绍显示还是隐藏  初始化
function SetDeductionBouchersIcon()
    if AdvDeductionvoucher.SDKvoucherNum>0 then
        --local Item= top.transform:Find("Top").gameObject
        --Item.transform.anchorMin = UnityEngine.Vector2(0, 0)
        --Item.transform.anchorMax = UnityEngine.Vector2(1, 1)
    else
        if this["QuestionItem"] and this["QuestionItem"]~=1 then
            CSAPI.SetGOActive(this["QuestionItem"].gameObject, false);
        end
    end
end
---抵扣券说明书
function RefreshDeductionBouchers()
    if CSAPI.IsADV() then
        if  currPageData:GetShowType()==ShopShowType.Package  then --礼包
            QuestionItemSetActive(true)
        elseif currPageData:GetShowType()==ShopShowType.Pay then --充值
            QuestionItemSetActive(true)
        else
            QuestionItemSetActive(false)
        end
    else
        QuestionItemSetActive(false)
    end
end
---控制抵抵扣券说明显示或者隐藏
function QuestionItemSetActive(Active)
    if this["QuestionItem"] and this["QuestionItem"]~=1 then
        if FirstEnterQuestionItem then
            FirstEnterQuestionItem=false;
            local Item= this["QuestionItem"].gameObject;
            Item.transform.localPosition = UnityEngine.Vector3(Item.transform.localPosition.x-CSAPI.UIFitoffsetTop()-CSAPI.UIFoffsetBottom(), Item.transform.localPosition.y,0)
            local RectTransformItem=Item:GetComponent("RectTransform");
            RectTransformItem.pivot=UnityEngine.Vector2(1,0.5)
            RectTransformItem.anchorMax=UnityEngine.Vector2(1,1)
            RectTransformItem.anchorMin=UnityEngine.Vector2(1,1)
            RectTransformItem.anchoredPosition=UnityEngine.Vector2(-470,-60)
        end
        if AdvDeductionvoucher.SDKvoucherNum>0 then
            if CSAPI.IsADV() then
                CSAPI.SetGOActive(this["QuestionItem"].gameObject, Active);
            else
                CSAPI.SetGOActive(this["QuestionItem"].gameObject, false);
            end
        else
            CSAPI.SetGOActive(this["QuestionItem"].gameObject, false);
        end
    else
        FirstEnterQuestionItem=true;
    end
end

--创建月卡说明物体 测试用，正式版删除
function CreateMonthItemsTest()
    if currPageData:GetShowType()~=ShopShowType.MonthCard then
        return
    end
    local monthCardData=currPageData:GetCommodityInfos(true)[1];
    local datas=monthCardData:GetCommodityList();
    local list={};
    for k,v in ipairs(datas) do
        if v.cid==10030 then
            table.insert(list,{goods=v,desc=LanguageMgr:GetTips(15101)});
            break
        end
    end
    for k,v in ipairs(list) do
        local pos={0,(k-1)*137,0};
        local d=list[#list-k+1];
        if k>#monthCardItems then
            ResUtil:CreateUIGOAsync("Shop/MonthCardItem",layoutObj,function(go)
				tab=ComUtil.GetLuaTable(go);
				tab.Refresh(d,pos,isHideMonthPay);
				table.insert(monthCardItems,tab);
			end);
        else
            monthCardItems[k].Refresh(d,pos);
        end
    end
end

--创建月卡说明物体
function CreateMonthItems()
    if currPageData:GetShowType()~=ShopShowType.MonthCard then
        return
    end
    local monthCardData=currPageData:GetCommodityInfos(true)[1];
    local datas=monthCardData:GetCommodityList();
    local list={};
    for k,v in ipairs(datas) do
        if v.data:GetType()==ITEM_TYPE.PROP then
            for _,val in ipairs(v.data:GetDropList()) do
                table.insert(list,{goods=val,desc=LanguageMgr:GetByID(24021)});
            end
        else
            table.insert(list,{goods=v,desc=LanguageMgr:GetByID(24020)});
        end
    end
    for k,v in ipairs(list) do
        local pos={0,(k-1)*137,0};
        local d=list[#list-k+1];
        if k>#monthCardItems then
            ResUtil:CreateUIGOAsync("Shop/MonthCardItem",layoutObj,function(go)
				tab=ComUtil.GetLuaTable(go);
				tab.Refresh(d,pos);
				table.insert(monthCardItems,tab);
			end);
        else
            monthCardItems[k].Refresh(d,pos);
        end
    end
end

--二级页签点击
function OnChildTabChange(eventData)
    childPageID=eventData.cfg.id;
    currChildPage=eventData.cfg;
    --记录红点状态并更新数据,无用
    -- if currPageData:GetCommodityType()==CommodityType.Promote then
    --     local info=ShopMgr:GetPromoteInfo(childPageID)
    --     info:SetRed(false);
    --     RoleAudioPlayMgr:StopSound();
    -- end
    Refresh();
end

function OnPageChange(eventData)
    if eventData then
        lastPageIndex=currPageIndex;
        currPageIndex=eventData;
        childPageID=nil;
        currChildPage=nil;
        Refresh();
    end
end

function OnClickBack()
    view:Close();
end

--点击兑换
function OnClickExchange()
    local list=BagMgr:GetCardElems(true);
    --剔除未持有卡牌的星源数据
    local lt={};
    for k,v in ipairs(list) do
        local c=v:GetCfg();
        if c.id==107101 then--总队长
            table.insert(lt,v);
        elseif c and c.dy_arr then
            local cards=RoleMgr:GetCardsByCfgID(c.dy_arr[1]) 
            if cards and #cards>=1 then--持有的卡牌才列入计算
                table.insert(lt,v);
            end
        end
    end
    if lt and #lt>0 then
        CSAPI.OpenView("RoleExchangeView",lt);
    else
        Tips.ShowTips(LanguageMgr:GetTips(15105));
    end
end

--点击时装图册
function OnClickSkinSet()
    CSAPI.OpenView("SkinSetView")
end

--点击商品
function OnClickGrid(lua)
    ShopCommFunc.OpenPayView(lua.data,currPageData);
end

--点击礼包类型展示的商品
function OnClickPackage(lua)
    ShopCommFunc.OpenPayView(lua.data,currPageData);
end

--购买返回
function OnBuyRet(proto)
    -- LogError(proto);
    if proto then
        local comm=ShopMgr:GetFixedCommodity(proto.id);
        local priceInfo=comm:GetRealPrice();
        local isPay=false;
        local price=0;
        if priceInfo and priceInfo[1].id==-1  then
            isPay=true;
            price=priceInfo[1].num;
        elseif priceInfo~=nil then
            price=priceInfo[1].num;
        end
        if not isPay then --非充值则上传订单信息
            local gets=comm:GetCommodityList();
            local currNum=1;
            local currPrice=price;
            if proto.gets then
                for k,v in ipairs(proto.gets) do
                    if v.id==gets[1].cid then
                        currNum=math.modf(v.num/gets[1].num);
                        currPrice=math.modf(currNum*price);
                        break;
                    end
                end
            else
                currPrice=price;
            end
            --数数记录购买
            local record={
                store_type=tostring(currPageData:GetID()),
                goods_id=tostring(comm:GetID()),
                goods_name=comm:GetName(),
                goods_num=currNum,
                cost_type=priceInfo~=nil and tostring(priceInfo[1].id) or "免费",
                cost_num=currPrice,
            }
            if CSAPI.IsADV()==false then
                BuryingPointMgr:TrackEvents("store_buy",record )
            end
        end
        if comm:GetType()==CommodityItemType.MonthCard then --月卡
            ClientProto:GetMemberRewardInfo();
        end
    end
    Refresh();
end

--兑换返回
function OnExchangeRet(proto)
    if proto then
        local randData=ShopMgr:GetExchangeItem(proto.cfgid,proto.id);
        local comm=RandCommodityData.New();
        comm:SetData(randData,randData.index);
        local priceInfo=comm:GetRealPrice();
        if priceInfo[1].id~=-1 then --非充值则上传订单信息
            local gets=comm:GetCommodityList();
            local currNum=1;
            local currPrice=1;
            if proto.gets then
                for k,v in ipairs(proto.gets) do
                    if v.id==gets[1].cid then
                        currNum=math.modf(v.num/gets[1].num);
                        currPrice=math.modf(currNum*priceInfo[1].num);
                        break;
                    end
                end
            else
                currPrice=priceInfo[1].num;
            end
            --数数记录购买
            local record={
                store_type=tostring(currPageData:GetID()),
                goods_id=tostring(comm:GetID()),
                goods_name=comm:GetName(),
                goods_num=currNum,
                cost_type=priceInfo~=nil and tostring(priceInfo[1].id) or "免费",
                cost_num=currPrice,
            }
            -- LogError(record)
            if CSAPI.IsADV()==false then
                BuryingPointMgr:TrackEvents("store_buy",record )
            end
        end
    end
    Refresh();
end

function OnClickRefresh()
    local costInfo=ShopMgr:GetExChangeRefreshCost(shopID)
    if costInfo~=nil then
        if costInfo[1]==0 then--免费
            SetRandCommodity(true);
        else
            local cfg=Cfgs.ItemInfo:GetByID(costInfo[1]);
            local count=BagMgr:GetCount(costInfo[1]);
            if count<costInfo[2] then --消耗道具不足
                CSAPI.OpenView("Prompt", {content = string.format( LanguageMgr:GetTips(15000),cfg.name)});
                return;
            end
            local content=string.format( LanguageMgr:GetTips(15005), cfg.name.."X"..costInfo[2]);
            local dialogdata = {}
            dialogdata.content = content
            dialogdata.okCallBack = function()
                SetRandCommodity(true);
            end
            CSAPI.OpenView("Dialog", dialogdata)
        end
    else
        SetRandCommodity(false);
    end
end

function OnClickCoreDetails()
    CSAPI.OpenView("CoreExchangeDetails");
end

--检测商店页刷新
function CheckPageRefresh()
    if data==nil then
        local openList=ShopMgr:GetAllPages(true);
        if openList then
            local tempList=nil;
            if lastPageIDs then
                for k,v in pairs(lastPageIDs) do
                    local hasOld=false;
                    local hasNew=false;
                    for key,val in ipairs(openList) do
                        if currPageData and val:GetID()==currPageData:GetID() and tempList==nil then
                            tempList=val:GetTopTabs(true);
                        end
                        if val:GetID()==tonumber(k) then
                            hasOld=true;
                            break;
                        elseif lastPageIDs[val:GetID()]==nil then
                            hasNew=true;
                            break;
                        end
                    end 
                    if hasOld~=true or hasNew==true then
                        --刷新商店页面
                        OnShopTagRefresh();
                        break;
                    end
                end
                
            end
            if tempList and lastChildPageIDs then
                for k,v in pairs(lastChildPageIDs) do
                    local hasOld=false;
                    local hasNew=false;
                    for key,val in ipairs(tempList) do
                        if val.id==tonumber(k) then
                            hasOld=true;
                            break;
                        elseif lastChildPageIDs[val.id]==nil then
                            hasNew=true;
                            break;
                        end
                    end 
                    if hasOld~=true or hasNew==true then
                        --刷新商店页面
                        OnShopTagRefresh();
                        break;
                    end
                end
            end
        end
    end
end

function RecordPageIDs()
    lastPageIDs={};
    if pages then
        for k,v in ipairs(pages) do
            lastPageIDs[v:GetID()]=true;
        end
    end
end

function RecordChildPageIDs()
    lastChildPageIDs={};
    if childTabDatas then
        for k,v in ipairs(childTabDatas) do
            lastChildPageIDs[v.id]=true;
        end
    end
end

--动画
function LoopTween()
    t_countTime=t_countTime+Time.deltaTime;
    if isFirstTween then
        if t_countTime>=f_tTime then
            CSAPI.SetGOActive(tween_angle1,true);
            isFirstTween=false;
            t_index=1;
            isPlaying=true;
            t_countTime=0;
        end
    elseif isPlaying then
        if t_countTime>=s_tTime[t_index] then
            if t_index==2 then
                isPlaying=false;
                t_index=0;
                CSAPI.SetGOActive(tween_angle1,false);
                CSAPI.SetGOActive(tween_angle2,false);
                CSAPI.SetAngle(nilImg,0,0,0)
            else
                t_index=t_index+1;
                CSAPI.SetGOActive(tween_angle1,t_index==1);
                CSAPI.SetGOActive(tween_angle2,t_index==2);
            end
            t_countTime=0;
        end
    elseif t_countTime>=l_tTime then
        isPlaying=true;
        t_index=1;
        CSAPI.SetGOActive(tween_angle1,true);
        t_countTime=0;
    end
end

function SetNewInfo(infos)
    newInfos=infos;
    -- Refresh();
end

function ReleaseCSComRefs()     
    gameObject=nil;
    transform=nil;
    this=nil;  
    bg=nil;
    viewObj=nil;
    sv=nil;
    sv2=nil;
    cardPage=nil;
    videoNode=nil;
    layoutObj=nil;
    txt_cardTips=nil;
    btn_pay=nil;
    txt_price=nil;
    pageTween=nil;
    bottomObj=nil;
    refreshObj=nil;
    btnRefresh=nil;
    txt_refreshTime=nil;
    tweenRefresh=nil;
    refreshTweenObj=nil;
    tweenbottom=nil;
    promoteObj=nil;
    bottomTweenObj=nil;
    topObj=nil;
    tweenTop=nil;
    topTweenObj=nil;
    leftParent=nil;
    mask=nil;
    top=nil;
    view=nil;
end