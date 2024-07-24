-- 选择角色
local BGSelectData = require("BGSelectData")
local curID = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    -- layout:AddBarAnim(0.4, false)
    layout:Init("UIs/CRoleDisplay/BGSelectItem", LayoutCallBack, true)
    tlua1 = UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.Normal)

    btnS_cg = ComUtil.GetCom(btnS, "CanvasGroup")

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Bag_Update, RefreshPanel)
end
function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB)
        lua.Refresh(_data, curID)
    end
end

function ItemClickCB(_data)
    if (curID ~= _data:GetID()) then
        curID = _data:GetID()
        SetBGFunc(curID, false)
        layout:UpdateList()
        SetBtn(_data)
    end
end

function OnOpen()
    SetBGFunc = data
    useID = PlayerClient:GetBG()
    curID = useID

    RefreshPanel()
end

function RefreshPanel()
    InitData()
    SetBtn()
end

function InitData()
    curDatas = {}
    local cfgs = Cfgs.CfgMenuBg:GetAll()
    for k, v in pairs(cfgs) do
        local _data = BGSelectData.New()
        _data:Init(v)
        table.insert(curDatas, _data)
    end
    table.sort(curDatas, function(a, b)
        if (a:GetSortIndex() == b:GetSortIndex()) then
            return a:GetID() < b:GetID()
        else
            return a:GetSortIndex() < b:GetSortIndex()
        end
    end)
    layout:IEShowList(#curDatas)
end
function GetCurData()
    for k, v in pairs(curDatas) do
        if (v:GetID() == curID) then
            return v
        end
    end
end

function OnClickC()
    SetBGFunc(useID, true)
    view:Close()
end

function OnClickS()
    local curData = _data or GetCurData()
    if (curData:IsGet()) then
        PlayerProto:SetBackground(curID, function(id)
            SetBGFunc(curID, true)
            view:Close()
        end)
    else
        if (curData:GetCfg().jumpID) then
            JumpMgr:Jump(curData:GetCfg().jumpID)
        end
    end
    -- SetBGFunc(curID,true)
    -- PlayerClient:SetBG(curID)
    -- EventMgr.Dispatch(EventType.Player_Select_BG)
    -- view:Close()
end

function OnClickMask()
    -- OnClickC()
end
---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if OnClickC then
        OnClickC()
    end
end

function SetBtn(_data)
    local curData = _data or GetCurData()
    local lanID = curData:IsGet() and "7012" or "7039"
    LanguageMgr:SetText(txtS1, lanID)
    LanguageMgr:SetEnText(txtS2, lanID)
    local alpha = 1
    if(not curData:IsGet() and curData:GetCfg().jumpID == nil) then 
        alpha = 0.5 
    end 
    btnS_cg.alpha = alpha
end
