function Refresh(data)
    CSAPI.SetAnchor(gameObject, data[1], data[2])
    cfgID = data[3]
end

function OnClick()
    local cardData = RoleMgr:GetMaxFakeData(cfgID)
    CSAPI.OpenView("RoleInfo", cardData)
end
