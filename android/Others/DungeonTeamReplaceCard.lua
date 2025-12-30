local isCheckCard = false
local card = nil
local item = nil

function SetClickCB(_cb)
    cb = _cb
end

--teamItemData
function Refresh(_data,_elseData)
    data = _data
    isCheckCard = _elseData and _elseData.isCheckCard
    if data then
        SetLeader()
        card = data:GetCard()
        if card then
            SetName()
            SetItem()
            SetShow()
        end
    end
end

function SetLeader()
    CSAPI.SetGOActive(leaderImg,data:IsLeader())
end

function SetName()
    CSAPI.SetText(txtName,card:GetName() or "")
end

function SetItem()
    if item then
        item.Refresh(card)
    else
        ResUtil:CreateUIGOAsync("RoleLittleCard/RoleSmallCard",itemParent,function (go)
            item = ComUtil.GetLuaTable(go)
            item.SetClickCB(cb)
            item.Refresh(card)
        end)
    end
end

function SetShow()
    if isCheckCard then
        local isHas = CRoleMgr:GetData(card:GetCfgID()) ~= nil
        if RoleMgr:IsLeader(card:GetCfgID()) then
            isHas = true
        end
        CSAPI.SetGOAlpha(itemParent, isHas and 1 or 0.5)
    else
        CSAPI.SetGOAlpha(itemParent,1)
    end
end
