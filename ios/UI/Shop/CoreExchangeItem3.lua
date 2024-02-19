local str="%s<color=#ffc146>X%s</color>";
function Refresh(_d)
    if _d then
        ResUtil.IconGoods:Load(icon1,string.format("Role_splinter_%s",_d.stars),false,function()
            CSAPI.SetRTSize(icon1,80,80);
        end);
        ResUtil.RoleCard_BG:Load(icon2,string.format("img_01_0%s",_d.stars));
        local cfg=Cfgs.ItemInfo:GetByID(_d.gets[1]);
        if cfg then
            ResUtil.IconGoods:Load(icon3,cfg.icon.."_1",false,function()
                CSAPI.SetRTSize(icon3,82.8,82.8);
            end);
            CSAPI.SetText(txt3,string.format(str,cfg.name,_d.gets[2]));
        end
        if _d.stars==4 or _d.stars==6 then
            CSAPI.SetAnchor(icon3,174,6.1);
            CSAPI.SetAnchor(txt3,664,-45.1);
        end
    end
end