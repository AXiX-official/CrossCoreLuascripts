local cfg = nil
local info = nil
local curDatas = {}
local page = nil
function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Activity6/EXchangeItem", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Opened,OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClose)
    eventMgr:AddListener(EventType.SpecialDrops_Info_Update,OnInfoUpdate)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data)
    end
end

function OnItemClickCB(item)
    local _data = item.GetData()
    ShopCommFunc.OpenPayView(_data,page,OnSuccess)
end

function OnSuccess()
    SetData()
end

function OnViewOpened(viewKey)
    if (viewKey == "RewardPanel") then
        layout:IEShowList(0)
        ActivityMgr:CheckRedPointData(ActivityListType.Exchange)
    end
end

function OnViewClose(viewKey)
    if (viewKey == "RewardPanel") then
        CSAPI.SetGOActive(animMask, true)
        tlua:AnimAgain()
        layout:IEShowList(#curDatas, function ()
            CSAPI.SetGOActive(animMask, false)
        end)
    end
end

function OnInfoUpdate()
    SetNum()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Refresh(_data,_elseData)
    cfg = _elseData and _elseData.cfg or nil
    if cfg then
        info = cfg.info and cfg.info[1] or nil
        SetTime()
        SetNum()
        SetData()
        SetItems()
        PlayAnim(600)
    end
end

function SetTime()
    if cfg.sTime then
       local tab =  TimeUtil:SplitTime(cfg.sTime)
       CSAPI.SetText(txtTime1,LanguageMgr:GetByID(22046) .. tab[1].."/"..tab[2].."/"..tab[3])
       CSAPI.SetText(txtTime2,tab[4]..":"..tab[5]..":"..tab[6])
    end
    if cfg.eTime then
        local tab =  TimeUtil:SplitTime(cfg.eTime)
        CSAPI.SetText(txtTime3,tab[1].."/"..tab[2].."/"..tab[3])
        CSAPI.SetText(txtTime4,tab[4]..":"..tab[5]..":"..tab[6])
    end
end

function SetNum()
    local str= "："
    if info and info.goodId then
        ResUtil.IconGoods:Load(icon,info.goodId)
        local cur =PlayerMgr:GetSpecialDrop(info.goodId)
        local max = 0
        local cfgs = Cfgs.CfgDropItem:GetAll()
        if cfgs then
            for _, cfg in pairs(cfgs) do
                if cfg.DropItemID and cfg.DropItemID == info.goodId then
                    max = cfg.DropMax or 0
                    break
                end
            end
        end
        str = str ..cur.."/"..max
    end
    CSAPI.SetText(txtNum,str)
end

function SetData()
    if info and info.shopId  then
        page = ShopMgr:GetPageByID(info.shopId)
        if page then
            curDatas = page:GetCommodityInfos(true)
            if #curDatas > 0 then
                table.sort(curDatas,function (a,b)
                    if (a:IsOver() and b:IsOver()) or(not a:IsOver() and not b:IsOver()) then
                        return a:GetID() < b:GetID()
                    else
                        return not a:IsOver()
                    end
                end)
            end
        end
    end
end

function SetItems() 
    tlua:AnimAgain()
    layout:IEShowList(#curDatas)
end

function PlayAnim(time)
    CSAPI.SetGOActive(animMask,true)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(animMask,false)
    end,this,time)
end

