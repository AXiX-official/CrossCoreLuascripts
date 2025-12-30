local packQualitys2 = {"img_25_05", "img_25_04", "img_25_03", "img_25_02", "img_25_01", "img_25_06"}

-- 如 [10040,30,2]
function Refresh(_reward)
    reward = _reward
    local cfg = Cfgs.ItemInfo:GetByID(reward[1])
    -- bg 
    ResUtil.Commodity:Load(border, packQualitys2[cfg.quality])
    -- icon 
    ResUtil.IconGoods:Load(icon, cfg.icon)
    -- 
    CSAPI.SetText(txtNum, reward[2] .. "")
end

function OnClick()
    local itemData = BagMgr:GetFakeData(reward[1], reward[2])
    GridRewardGridFunc({
        data = itemData
    })
end
