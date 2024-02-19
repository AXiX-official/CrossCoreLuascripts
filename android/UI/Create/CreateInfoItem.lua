function Refresh(_data)
    quality = _data[1]
    datas = _data[2]

    LanguageMgr:SetText(txtStar, 17027, quality)
    --
    ResUtil.RoleCard_BG:Load(imgStar, "img_01_0" .. quality)
    -- CSAPI.LoadImg(imgStar, "UIs/Create/img_12_0" .. quality .. ".png", true, nil, true)
    --
    local percent = 0
    local pickUpPercent = 0
    for k, m in pairs(datas) do
        percent = percent + tonumber(m.s_probability)
        if (m.desc) then
            pickUpPercent = pickUpPercent + tonumber(m.s_probability)
        end
    end
    local str = ""
    if (pickUpPercent ~= 0) then
        local p = math.ceil(pickUpPercent / percent * 100) .. "%"
        str = LanguageMgr:GetByID(17028, quality, p)
    end
    CSAPI.SetText(txtPU, str)
    -- grid
    --local _datas = RomoveUp()
    items = items or {}
    ItemUtil.AddItems("RoleLittleCard/CreateProItem", items, datas, grid)

    CSAPI.SetText(txtPercent, "<color=#ffc146>" .. (percent * 100) .. "%</color>")
end

-- -- 去除单Up角色
-- function RomoveUp()
--     local _datas = {}
--     for k, v in ipairs(datas) do
--         if (not v.s_up_probability) then
--             table.insert(_datas, v)
--         end
--     end
--     return _datas
-- end
