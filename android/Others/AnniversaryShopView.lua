local data = nil
local layout = nil
local curDatas = nil
function Awake()
    layout = ComUtil.GetCom(hsv, "UISV")
    layout:Init("UIs/Shop/VCommodityItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()    
    eventMgr:AddListener(EventType.Shop_Buy_Ret,OnBuyRet)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index);
    if lua then
        local _data = curDatas[index];
        local shopData = ShopMgr:GetPageByID(_data:GetShopID())
        lua.SetClickCB(OnClickPackage)
        lua.Refresh(_data,{commodityType=shopData:GetCommodityType(),showType=shopData:GetShowType()})
    end
end

--点击礼包类型展示的商品
function OnClickPackage(lua)
    local shopData = ShopMgr:GetPageByID(lua.data:GetShopID())
    ShopCommFunc.OpenPayView(lua.data,shopData);
end

function OnBuyRet()
    SetDatas()
    SetItems()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Refresh(_data)
    data = _data
    if data then
        SetDatas()
        SetItems()
    end
end

function SetDatas()
    local ids = data:GetCommodityId()
    if ids then
        curDatas = {}
        for i, v in ipairs(ids) do
            local comm = ShopMgr:GetFixedCommodity(v)
            if comm:IsShow() then
                table.insert(curDatas,comm)
            end
        end
    end
end

function SetItems()
    if curDatas then
        layout:IEShowList(#curDatas)
    end
end