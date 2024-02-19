local data=nil;
local click=nil;
function Refresh(_data,_click)
    data=_data;
    click=_click;
    if data.img then
        CSAPI.LoadImg(gameObject,string.format("UIs/ShopPromote/%s.png",data.img),true,function()
            CSAPI.SetImgColor(gameObject,255,255,255,255);
        end,true);
    end
end

function OnClick()
    -- if jumpId then
    --     JumpMgr:Jump(jumpId);
    -- end
    if click then
        if data then
            click(data.jumpId,data.shopId,data.topId,data.commId);
        else
            click();
        end
    end
end