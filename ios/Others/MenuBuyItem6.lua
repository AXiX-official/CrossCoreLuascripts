local packQualitys2 = {"img_25_05", "img_25_04", "img_25_03", "img_25_02", "img_25_01", "img_25_06"}

-- CfgSignRewardItem
function Refresh(_cfg)
    reward = _cfg.rewards[1]
    local cfg = Cfgs.ItemInfo:GetByID(reward[1])
    -- bg 
    ResUtil.Commodity:Load(bg, packQualitys2[cfg.quality])
    -- icon 
    ResUtil.IconGoods:Load(icon, cfg.icon)
    -- name
    CSAPI.SetText(txtName, cfg.name)
    -- count
    CSAPI.SetText(txtNum, reward[2] .. "")
end

function OnClick()
    local itemData = BagMgr:GetFakeData(reward[1], reward[2])
    GridRewardGridFunc({
        data = itemData
    })
end
