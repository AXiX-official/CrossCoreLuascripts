-- 选择角色
local curID = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    --layout:AddBarAnim(0.4, false)
    layout:Init("UIs/CRoleDisplay/BGSelectItem", LayoutCallBack, true)
    tlua1 = UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.Normal)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB)
        lua.Refresh(_data,curID,useID)
    end
end

function ItemClickCB(_cfg)
    local id = _cfg.id
    if (curID ~= id) then
        curID = id
        SetBG(curID,false)
		layout:UpdateList()
    end
end

function OnOpen()
    SetBG = data
    useID = PlayerClient:GetBG()
    curID = useID
    curDatas = Cfgs.CfgMenuBg:GetAll()
    layout:IEShowList(#curDatas)
end

function OnClickC()
	SetBG(useID,true)
	view:Close()
end

function OnClickS()
	SetBG(curID,true)
    PlayerClient:SetBG(curID)
    EventMgr.Dispatch(EventType.Player_Select_BG)
    view:Close()
end

function OnClickMask()
	--OnClickC()
end
---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if  OnClickC then
        OnClickC()
    end
end