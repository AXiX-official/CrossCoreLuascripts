local data=nil;
function Refresh(d,desc,isShowDesc)
    data=d;
    if isShowDesc then
        CSAPI.SetText(txt_name,string.format("%s(%s)",data:GetName(),desc));
    else
        CSAPI.SetText(txt_name,data:GetName());
    end
    CSAPI.SetText(txt_num,"X"..data:GetCount());
end

function OnClickDetail()
    --显示物品详情
    if data then
        UIUtil:OpenGoodsInfo(data,2)
    end
end