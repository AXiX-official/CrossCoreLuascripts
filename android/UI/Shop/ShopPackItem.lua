local data=nil;
local comm=nil
function Refresh(d,desc,isShowDesc,_comm)
    data=d;
    comm=_comm
    if isShowDesc then
        CSAPI.SetText(txt_name,string.format("%s(%s)",data:GetName(),desc));
    else
        CSAPI.SetText(txt_name,data:GetName());
    end
    CSAPI.SetText(txt_num,"X"..data:GetCount());
end

function OnClickDetail()
    --显示物品详情
    if data and data:GetCfg().type==ITEM_TYPE.SKIN and data:GetCfg().dy_value2 then
        OpenSearchView(data:GetCfg().dy_value2);
    elseif data and data:GetCfg().type==ITEM_TYPE.LIMITED_TIME_SKIN and data:GetCfg().dy_arr then
        OpenSearchView(data:GetCfg().dy_arr[1]);
    elseif data then
        UIUtil:OpenGoodsInfo(data,2)
    end
end

function OpenSearchView(id)
    if id then
        local isShowImg=false;
        local l2dOn=false;
        if g_FHXOpenSkin ~= true and comm then
            isShowImg=comm:IsShowImg();
            l2dOn=true
        end
        CSAPI.OpenView("RoleInfoAmplification", {id, l2dOn,isShowImg},LoadImgType.Main)
    end
end
