-- 多人插图 
function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end

-- _data: CfgArchiveMultiPicture  _elseData 根据key来划分数据
function Refresh(_data, _elseData)
    data = _data
    elseData = _elseData or {}

    isUse = elseData.useID and elseData.useID == data:GetID() or false
    isSelect = elseData.curID and elseData.curID == data:GetID() or false

    -- icon
    ResUtil.MultBoard:Load(icon, data:GetIcon())
    -- name 
    CSAPI.SetText(txtName, data:GetName())
    -- use 
    CSAPI.SetGOActive(use, isUse)
    -- select
    CSAPI.SetGOActive(select, isSelect)
    -- objs
    --CSAPI.SetGOActive(obj1, data:GetL2dName() ~= nil) --和谐隐藏
    --CSAPI.SetGOActive(obj2, data:GetMv() ~= nil)
    --CSAPI.SetGOActive(obj3, data:GetTag() ~= nil)
    CSAPI.SetText(txtObj3, data:GetTag() or "")
    -- 是否解锁
    CSAPI.SetGOActive(lock, not data:IsHad())
end

function OnClick()
    if (cb) then
        cb(data)
    end
end

