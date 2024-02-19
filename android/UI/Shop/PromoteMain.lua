--推荐主界面
local mainId=140003;
local centerId=140002;
local rightId=140016;
local bLeftId=140002;
local bRightId=140002;
local mainImgs={};
local leftImgs={}
local mainDatas={{img="img_37_06",jumpId=140002,shopId=3,topId=nil,commId=30023}};
-- local rightDatas={"img_04_01","img_04_02"};
local layout=nil;
-- local layout2=nil;
function Awake()
    -- if CSAPI.IsIOS() then
    --     mainDatas={"img_46_01"};
    -- end
    layout = ComUtil.GetCom(hpage, "UISlideshow")
    layout:Init("UIs/ShopPromote/PromoteImg", LayoutCallBack, true)
    -- layout2 = ComUtil.GetCom(rpage, "UISlideshow")
    -- layout2:Init("UIs/ShopPromote/PromoteImg1", LayoutCallBack2, true)
end

function Refresh()
    --生成子物体
    layout:IEShowList(#mainDatas);
    -- layout2:IEShowList(#rightDatas);
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        lua.Refresh(mainDatas[index],OnClickItem);
    end
end

-- function LayoutCallBack2(index)
--     local lua = layout2:GetItemLua(index)
--     if (lua) then
--         lua.Refresh(rightDatas[index],rightId);
--     end
-- end

function OnClickML()
    JumpMgr:Jump(centerId);
    OpenBuyConfrim(3,nil,30015);
end

function OnClickBL()
    JumpMgr:Jump(bLeftId);
    OpenBuyConfrim(3,nil,30020);
    -- EventMgr.Dispatch(EventType.Shop_Jump_Refresh,{pageID=4});
end

function OnClickBR()
    JumpMgr:Jump(bRightId);
    OpenBuyConfrim(3,nil,30001);
    -- EventMgr.Dispatch(EventType.Shop_Jump_Refresh,{pageID=4});
end

function OnClickItem(jumpId,shopId,topId,commId)
    if jumpId and shopId and commId then
        JumpMgr:Jump(jumpId);
        OpenBuyConfrim(shopId,topId,commId);
    end
end

function OpenBuyConfrim(shopId,topId,commID)
    if shopId==nil or commID==nil then
        return;
    end
    local pageData=ShopMgr:GetPageByID(shopId);
    if pageData and pageData:IsOpen() then
        local list=pageData:GetCommodityInfos(true,topId);
        local commData=nil;
        if list then
            for k,v in ipairs(list) do
                if v:GetID()==commID then
                    commData=v;
                    break;
                end
            end
            if commData==nil then
                return;
            end
            ShopCommFunc.OpenPayView(commData,pageData);
        end
    end
end