local isDrag = false

-- local pressTimer = 0.2 -- 大于该值表示按住，否则是丢出
-- local timer = 0
-- local isFirst = nil
-- local num = 200

function Awake()
    click_clickNode = ComUtil.GetCom(clickNode, "ButtonCallLua")
    drag_clickNode = ComUtil.GetCom(clickNode, "DragCallLua")
    polygon = ComUtil.GetCom(clickNode,"PolygonColliderImage")
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

    polygon:AutoScale()
end

function OnClick()
    if (cb) then
        cb(cfgChild)
    end
end

function OnBeginDragXY(_x, _y)
    if (not parentLua.IsIdle()) then
        return
    end

    -- timer = Time.time
    -- isFirst = nil

    x = _x
    y = _y
    parentLua.ItemDragBeginCB(cfgChild)
end

function OnDragXY(_x, _y)
    if (not parentLua.IsIdle()) then
        return
    end

    -- if ((Time.time - timer) < pressTimer) then
    --     return
    -- end
    -- if (isFirst == nil) then
    --     isFirst = 1
    --     x = _x
    --     y = _y
    --     parentLua.ItemDragBeginCB(cfgChild)
    -- end

    parentLua.ItemDragCB(cfgChild, _x - x, _y - y)
    x = _x
    y = _y
end

function OnEndDragXY(_x, _y)
    -- if ((Time.time - timer) < pressTimer) then
    --     CheckThrowOut(cfgChild, _x - x, _y - y)
    -- else
    parentLua.ItemDragEndCB(cfgChild)
    -- end
end

-- -- 检测丢出： 方向是否对，距离是否足够
-- function CheckThrowOut(cfgChild, x, y)
--     if (cfgChild.clickNum[4] == nil) then
--         return
--     end
--     local _num = 0
--     local type = cfgChild.gesture
--     local dir = 0
--     if (math.abs(x) > math.abs(y)) then
--         dir = x < 0 and 1 or 2
--         _num = x
--     else
--         dir = y > 0 and 3 or 4
--         _num = y
--     end
--     if (dir == cfgChild.gesture and math.abs(_num) > num) then
--         -- 是丢出
--         parentLua.ThrowOut(cfgChild)
--     end
-- end
