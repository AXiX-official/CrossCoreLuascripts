-- 角色皮肤信息界面
local list = nil;
local nowIdx = 1;
local lastIdx=1;
local layout = nil;
local svUtil = nil;
local roleItem=nil;
local l2dOn=true;
local curModelCfg=nil;
local btnFuncS=nil;
local btnFuncC=nil;
local card=nil;
local currSkinInfo=nil
local rSkinInfo=nil;--RoleSkinInfo
local eventMgr=nil;
local isFirst=true;
local isInit=false;
local roleItem2=nil
local countDown=0.46;

function Awake()
    layout = ComUtil.GetCom(hsv, "UISV")
    layout:Init("UIs/RoleSkinComm/SkinInfoItem", LayoutCallBack, true)
    layout:AddOnValueChangeFunc(OnValueChange);
    svUtil = SVCenterDrag.New();
    roleItem = RoleTool.AddRole(item1, nil, nil, false)		
    UIUtil:AddTop2("SkinFullInfo", gameObject, Close,nil,{});
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Card_Update, OnCardUpdate)
    eventMgr:AddListener(EventType.Card_Skin_Get, Refresh)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    -- l2dOn=RoleSkinMgr:GetL2DState()==true;
    if data then
        list = data.list
        nowIdx = data.idx or 1;
    else
        list = {};
    end
    if list and #list > 0 then
        svUtil:Init(layout,#list,{276,500},7,0.1,0.5);
        layout:IEShowList(#list, function()
            if not isInit then
                isInit=true;
                OnValueChange();
            end
        end, nowIdx);
    end
    Refresh();
end


function Refresh()
    if list and #list > 0 then
        currSkinInfo = list[nowIdx];
        rSkinInfo=nil;
        card=nil
        if currSkinInfo then
            -- 获取L2D按钮状态
            local hasL2d=currSkinInfo:HasL2D();
            CSAPI.SetGOActive(btnL2D, hasL2d);
            curModelCfg=currSkinInfo:GetModelCfg();
            local cards=RoleMgr:GetCardsByCfgID(curModelCfg.role_id);
            if cards then
                card=cards[1]
            end
            -- 初始化立绘
            roleItem.Refresh(currSkinInfo:GetModelID(), LoadImgType.SkinFull,nil,l2dOn)
            -- 初始化L2D按钮状态
            SetL2DState(l2dOn);
            --设置描述
            CSAPI.SetText(txt_desc,currSkinInfo:GetDesc());
            SetContent();
        else
            curModelCfg=nil;
        end
    else
        currSkinInfo=nil;
        curModelCfg=nil;
        card=nil;
        rSkinInfo=nil;
        LogError("无皮肤列表");
    end
    SetArrow(nowIdx);
end

function SetContent()
    -- 设置购买状态
    if currSkinInfo==nil then
        CSAPI.SetGOActive(btnCurrent,false);
        CSAPI.SetGOActive(btnSuit,false);
        return;
    end
    local getType,getTips=currSkinInfo:GetWayInfo();
    rSkinInfo=RoleSkinMgr:GetRoleSkinInfo(curModelCfg.role_id,curModelCfg.id);
    local has=rSkinInfo and rSkinInfo:CheckCanUse() or false;
    if has then
        if card then
            --判断当前是否穿戴着该皮肤
            local isSuit=card:GetSkinID()==currSkinInfo:GetModelID();
            CSAPI.SetGOActive(btnCurrent,isSuit);
            CSAPI.SetGOActive(btnSuit,not isSuit);
            CSAPI.SetText(txtS1,LanguageMgr:GetByID(18061));
            CSAPI.SetText(txtS2,LanguageMgr:GetByType(18061,4));
            local lid=isSuit and 18064 or 18065;
            CSAPI.SetText(txt_tips,LanguageMgr:GetByID(lid));
            SetClickFuncS(OnClickEquip);
            SetClickFuncC(nil)
        else
            CSAPI.SetText(txt_tips,LanguageMgr:GetByID(18066));
            CSAPI.SetGOActive(btnCurrent,false);
            CSAPI.SetGOActive(btnSuit,false);
            SetClickFuncC(nil)
        end
    else 
        if getType==SkinGetType.Store then
            CSAPI.SetText(txtS1,LanguageMgr:GetByID(18053));
            CSAPI.SetText(txtS2,LanguageMgr:GetByType(18053,4));
            CSAPI.SetText(txt_tips,string.format(LanguageMgr:GetByID(18067),curModelCfg.key,curModelCfg.desc));
            SetClickFuncS(OnClickBuy);
            CSAPI.SetGOActive(btnCurrent,false);
            --判断商品是否在购买期限内
            local isBtnShow=false
            if curModelCfg and curModelCfg.shopId then
                local commodity=ShopMgr:GetFixedCommodity(curModelCfg.shopId);
                isBtnShow=commodity:GetNowTimeCanBuy();
            end
            CSAPI.SetGOActive(btnSuit,isBtnShow);
        elseif getType==SkinGetType.Archive then
            CSAPI.SetText(txtS1,LanguageMgr:GetByID(18062));
            CSAPI.SetText(txtS2,LanguageMgr:GetByType(18062,4));
            CSAPI.SetText(txt_tips,getTips);--暂用
            SetClickFuncS(OnClickJump);
            CSAPI.SetGOActive(btnCurrent,false);
            CSAPI.SetGOActive(btnSuit,true);
        elseif getType==SkinGetType.Other then
            CSAPI.SetText(txtS1,LanguageMgr:GetByID(18063));
            CSAPI.SetText(txtS2,LanguageMgr:GetByType(18063,4));
            CSAPI.SetText(txt_tips,getTips);
            SetClickFuncS(OnClickJump);
            CSAPI.SetGOActive(btnCurrent,false);
            CSAPI.SetGOActive(btnSuit,true);
        else
            CSAPI.SetText(txt_tips,getTips);
            CSAPI.SetGOActive(btnCurrent,false);
            CSAPI.SetGOActive(btnSuit,false);
            SetClickFuncC(nil)
            SetClickFuncS(nil)
        end
    end
end

function OnCardUpdate()
    Tips.ShowTips(LanguageMgr:GetByID(18072));
    Refresh();
end

function LayoutCallBack(index)
    local _data = list[index]
    local item = layout:GetItemLua(index)
    item.Refresh(_data)
    item.SetIndex(index);
    item.SetSelect(index==nowIdx);
    item.SetClickCB(OnClickItem)
end

function OnValueChange()
    local index=layout:GetCurIndex();
    if index+1~=nowIdx then
        local item = layout:GetItemLua(nowIdx)
        if item then
            item.SetSelect(false);
        end
        lastIdx=nowIdx;
        nowIdx=index+1
        local item = layout:GetItemLua(nowIdx)
        if(item) then 
            item.SetSelect(true);
        end 
        if not isFirst then
            FuncUtil:Call(function()
                if nowIdx<lastIdx then
                    PlayMoveTween(true);
                else
                    PlayMoveTween();
                end
            end,nil,1)
        end
        SetArrow(nowIdx);
    end
    svUtil:Update();
end

function SetArrow(nowIdx)
    if nowIdx<=1 then
        CSAPI.SetImgColor(arrow1,255,255,255,122);
        CSAPI.SetImgColor(arrow2,255,255,255,255);
    elseif nowIdx==#list then
        CSAPI.SetImgColor(arrow1,255,255,255,255);
        CSAPI.SetImgColor(arrow2,255,255,255,122);
    else
        CSAPI.SetImgColor(arrow1,255,255,255,255);
        CSAPI.SetImgColor(arrow2,255,255,255,255);
    end
end

function OnClickItem(tab)
    layout:MoveToCenter(tab.GetIndex());
end

function OnClickL2D()
    l2dOn=not l2dOn;
    Refresh();
end

function SetClickFuncS(func)
    btnFuncS=func
end

function SetClickFuncC(func)
    btnFuncC=func
end

function OnClickSuit()
    if btnFuncS then
        btnFuncS();
    end
end

function OnClickCurrent()
    if btnFuncC then
        btnFuncC();
    end
end

--进入立绘查看界面
function OnClickSearch()
    if curModelCfg then
        CSAPI.OpenView("RoleInfoAmplification", {curModelCfg.role_id, curModelCfg.id, l2dOn}, LoadImgType.Main)
    end
end

function Close()
    -- 缓存L2D按钮的状态
    RoleSkinMgr:SetL2DState(l2dOn);
    view:Close();
end

function SetL2DState(isOn)
    local name="UIs/RoleSkinComm/btn_03_03.png";
    if isOn then
        name="UIs/RoleSkinComm/btn_03_02.png";
    end
    CSAPI.LoadImg(l2dState,name,true,nil,true);
end

--点击穿戴
function OnClickEquip()
    if card and currSkinInfo then
        RoleSkinMgr:UseSkin(card:GetID(), currSkinInfo:GetModelID(), card:GetSkinIDElse(),l2dOn)
    end
end

--跳转
function OnClickJump()
    if currSkinInfo then
        local jumpID=currSkinInfo:GetBuyInfo()
        if jumpID then
            JumpMgr:Jump(jumpID[1]);
        end
    end
end

--购买
function OnClickBuy()
    --打开购买界面
    local comm=ShopCommFunc.GetSkinCommodity(currSkinInfo:GetModelID());
    if comm then
        CSAPI.OpenView("ShopSkinBuy",comm);
    end
end

-- --播放立绘移动动画 isRTL:是否从右到左
-- function PlayMoveTween(isRTL)
--     CSAPI.SetGOActive(anim_left_out, true)
--     CSAPI.SetGOActive(anim_left_int, false)
--     local x1 = 0
--     local x2 = isRTL and 400 or -400
--     UIUtil:SetPObjMove(item1, x1, x2, 0, 0, 0, 0, function()
--         Refresh()
--         CSAPI.SetGOActive(anim_left_out, false)
--         CSAPI.SetGOActive(anim_left_int, true)
--         UIUtil:SetPObjMove(item1, -x2, x1, 0, 0, 0, 0, nil, 300, 100)
--     end, 300, 0)
-- end

-- 播放立绘移动动画 isRTL:是否从右到左
function PlayMoveTween(isRTL)
    local x1 = 0
    local x2 = isRTL and 400 or -400
    if(l2dOn) then 
        UIUtil:SetObjFade(item1, 1, 0, nil, 1, 299, 1)
    else 
        UIUtil:SetObjFade(item1, 1, 0, nil, 300, 1, 1)
    end 
    UIUtil:SetPObjMove(item1, x1, x2, 0, 0, 0, 0, function()
        Refresh()
        if(l2dOn) then 
            UIUtil:SetObjFade(item1, 0, 1, nil, 1, 1, 0)
        else 
            UIUtil:SetObjFade(item1, 0, 1, nil, 300, 1, 0)
        end 
        UIUtil:SetPObjMove(item1, -x2, x1, 0, 0, 0, 0, nil, 300, 1)
    end, 301, 1)
end


function Update()
    if isFirst then
        countDown=countDown-Time.deltaTime;
        if countDown<=0 then
            isFirst=false;
            CSAPI.SetGOActive(mask,false);
        end
    end
end