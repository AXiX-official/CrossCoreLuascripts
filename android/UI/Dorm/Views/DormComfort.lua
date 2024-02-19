-- 房间舒适度
local curIndex = nil
function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Dorm/DormComfortItem2", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data)
    end
end

function OnOpen()
    curRoomData = DormMgr:GetCurRoomCopyDatas()--DormMgr:GetCurRoomData()
    -- furnitureDatas = curRoomData:GetFurnitureDatas()
    -- num
    local cur, max = DormMgr:GetCurRoomCopyNum()--curRoomData:GetFurnitureNum()
    CSAPI.SetText(txtNum2, cur .. "/" .. max)
    -- comfort
    local comfort =DormMgr:GetCopyDatasComfort() --curRoomData:GetComfort()
    CSAPI.SetText(txtComfort2, string.format(comfort .. ""))
    -- effect
    local num = GCalHelp:DormTiredAddPerent(comfort) 
    LanguageMgr:SetText(txtEffect3, 32015, "+" .. num .. "%")
    -- grids
    Grids()
end

function Grids()
    items = items or {}
    local datas = table.copy(CfgFurnitureEnum)
    table.insert(datas, 1, {
        id = 0,
        sName = LanguageMgr:GetByID(3025),
        index = 0
    })
    -- table.sort(datas, function(a, b)
    --     return a.index < b.index
    -- end)
    ItemUtil.AddItems("Dorm/DormComfortItem1", items, datas, grids, ItemClickCB, 1, nil, function()
        ItemClickCB(items[1])
    end)
end

function ItemClickCB(item)
    if (curIndex and curIndex == item.index) then
        return
    end
    if (curIndex ~= nil) then
        items[curIndex].Select(false)
    end
    curIndex = item.index
    items[curIndex].Select(true)
    curDatas = {}
    local furnitureDatas = curRoomData--curRoomData:GetFurnitures()
    for i, v in pairs(furnitureDatas) do
        --local cfgID = GCalHelp:GetDormFurCfgId(v.id)
        --local cfg = Cfgs.CfgFurniture:GetByID(cfgID)
        if (item.data.id == 0 or v:GetCfg().sType == (item.data.id-1)) then
            table.insert(curDatas, v:GetCfg())
        end
    end
    if (#curDatas > 0) then
        table.sort(curDatas, function(a, b)
            if (a.comfort == b.comfort) then
                return a.id < b.id
            else
                return a.comfort > b.comfort
            end
        end)
    end
    layout:IEShowList(#curDatas)
end

function OnClickMask()
    view:Close()
end
function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    txtTitle = nil;
    txtComfort = nil;
    txtEffect = nil;
    txtNum = nil;
    grids = nil;
    vsv = nil;
    view = nil;
end
----#End#----
