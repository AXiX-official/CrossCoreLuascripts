local isDrag = false

function Awake()
    click_clickNode = ComUtil.GetCom(clickNode, "Button")
    drag_clickNode = ComUtil.GetCom(clickNode, "DragCallLua")
    polygon = ComUtil.GetCom(clickNode, "PolygonColliderImage")
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_cfgChild, _parentLua)
    cfgChild = _cfgChild
    parentLua = _parentLua

    -- area
    local area = cfgChild.areas[1]
    CSAPI.SetAnchor(clickNode, area[1], area[2])
    CSAPI.SetRTSize(clickNode, area[3], area[4])
    CSAPI.SetRectAngle(clickNode, 0, 0, area[5])
    -- btn
    local gesture = cfgChild.gesture or 0
    click_clickNode.enabled = gesture == 0
    drag_clickNode.enabled = gesture ~= 0
    -- hide (生成时默认一隐藏)
    local isHide = false
    if (cfgChild.content and cfgChild.content.isHide ~= nil) then
        isHide = true
    end
    CSAPI.SetGOActive(gameObject, not isHide)

    polygon:AutoScale()

    -- 设置鞋
    drag_clickNode.dragGO = nil
    drag_clickNode.move = false
    if (cfgChild.sType == SpineActionType.RoleDrag or cfgChild.sType == SpineActionType.ElseDrag) then
        if (cfgChild.content.drag ~= nil and cfgChild.content.drag.targetObjName ~= nil) then
            local dragObj = parentLua.l2dGo.transform:Find("pos/" .. cfgChild.content.drag.targetObjName).gameObject
            drag_clickNode.dragGO = dragObj
            drag_clickNode.move = true
        end
    end
end

function OnClick()
    if (cb) then
        cb(cfgChild)
    end
end

function OnBeginDragXY(_x, _y)
    -- if (not parentLua.IsIdle()) then
    --     return
    -- end
    x = _x
    y = _y
    parentLua.ItemDragBeginCB(cfgChild, _x, _y)
end

function OnDragXY(_x, _y)
    -- if (not parentLua.IsIdle()) then
    --     return
    -- end
    if (x == nil or y == nil) then
        x = _x
        y = _y
    end
    parentLua.ItemDragCB(cfgChild, _x - x, _y - y)
    x = _x
    y = _y
end

function OnEndDragXY(_x, _y)
    parentLua.ItemDragEndCB(cfgChild, _x, _y)
end

function GetIndex()
    return cfgChild.index
end
