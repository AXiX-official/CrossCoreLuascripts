-- 多人插图预览
-- data ->CfgArchiveMultiPicture 的 id
function OnOpen()
    local cfg = Cfgs.CfgArchiveMultiPicture:GetByID(data)
    local imgName=cfg.img;
    if openSetting==1 then
        imgName=cfg.img_replace or cfg.img;
    end
    ResUtil.MultiImg:Load(img, imgName, function()
        local posScale = cfg.imgPos or {0, 0, 1}
        CSAPI.SetAnchor(img, posScale[1], posScale[2], 0)
        CSAPI.SetScale(img, posScale[3], posScale[3], posScale[3])
    end, true)
end

function OnClickMask()
    view:Close()
end
