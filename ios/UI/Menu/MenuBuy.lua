function Refresh(_cfg)
    cfg = _cfg
    -- icon 
    CSAPI.LoadImg(icon, "UIs/Menu/" .. cfg.img .. ".png", true, nil, true)
    -- time
    local isShowTime = false
    if (cfg.nType == MenuBuyState.Commodity) then
        local num = ShopMgr:GetMonthCardDays()
        if (num > 0 and num <= 7) then
            isShowTime = true
            LanguageMgr:SetText(txtTime, 18082, num)
        end
    end
    CSAPI.SetGOActive(imgTime, isShowTime)
    -- red 
    SetRed()

    MenuMgr:SetMenuBuyID(cfg.id)
end

function SetRed()
    local isRed = false
    if (cfg.nType == MenuBuyState.First) then
        local amount = PlayerClient:GetPayAmount()
        if (amount / 100 >= 6) then
            isRed = true
        end
    end
    UIUtil:SetRedPoint(clickNode, isRed, 179, 72, 0)
end

function OnClick()
    if (cfg) then
        CSAPI.OpenView("MenuBuyPanel", cfg.id)
    end
end
