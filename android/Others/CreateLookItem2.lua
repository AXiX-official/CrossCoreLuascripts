function SetIndex(_index)
    index = _index
end
function Refresh(data,isFirst)
    if (data[3] == 0) then
        return
    end

    CSAPI.SetAnchor(gameObject, data[1], data[2])
    cfgID = data[3]
    cardData = RoleMgr:GetMaxFakeData(cfgID)
    -- 
    CSAPI.SetText(txtName, cardData:GetName())
    local goodsCfg = Cfgs.ItemInfo:GetByID(10053)
    ResUtil.IconGoods:Load(imgGoods, goodsCfg.icon)
    CSAPI.SetGOActive(objGet, index==1)
end

function OnClick()
    CSAPI.OpenView("RoleInfo", cardData)
end
