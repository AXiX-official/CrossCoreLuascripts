local data = nil
local gridItem1,gridItem2 
local isCanBuy = false
local tgl = nil

function Awake()
    tgl = ComUtil.GetCom(toggle, "Toggle")
    if not IsNil(tgl) then
        tgl.onValueChanged:AddListener(OnValueChanged)
    end
    CSAPI.SetGOActive(toggleImg,false)
end

function OnValueChanged(b)
    CSAPI.SetGOActive(toggleImg,b)
    local infos = FileUtil.LoadByPath("Activity_ExChange_Tip") or {}
    if not b and infos[data:GetID()] == nil then 
        return
    end
    local i = b and 1 or 0
    if infos[data:GetID()] and infos[data:GetID()] == i then --已有不需要记录
        return
    end
    infos[data:GetID()] = i
    FileUtil.SaveToFile("Activity_ExChange_Tip",infos)
    ActivityMgr:CheckRedPointData(ActivityListType.Exchange)
end

function OnDestroy()
    if not IsNil(tgl) then
        tgl.onValueChanged:RemoveListener(OnValueChanged)
    end
end

function SetIndex(idx)
    index= idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    if data then
        SetExchange()
        SetGrid()
        SetState()
    end
end

function SetExchange()
    CSAPI.SetText(txtNum,LanguageMgr:GetByID(22044) .. data:GetNum())
end

function SetGrid()
    local reals =data:GetRealPrice()
    if reals and reals[1] then
        local gridData = GridFakeData(data:GetRealPrice()[1])
        if gridItem1 then
            gridItem1.Refresh(gridData)
            gridItem1.SetCount()
        else
            ResUtil:CreateUIGOAsync("Grid/GridItem",grid1,function (go)
                local lua = ComUtil.GetLuaTable(go)
                lua.SetClickCB(GridClickFunc.OpenInfoSmiple)
                lua.Refresh(gridData)
                lua.SetCount()
                gridItem1 = lua
            end)
        end
        local cur = BagMgr:GetCount(gridData.data.id)
        local max = gridData.data.num
        CSAPI.SetText(txtCount1,cur.."/"..max)
    end
    local gridDatas2 = data:GetCommodityList()
    if gridDatas2 and gridDatas2[1] then
        local gridData = gridDatas2[1]
        gridData.id = gridData.data.cfg.id
        gridData = GridFakeData(gridData)
        if gridItem2 then
            gridItem2.Refresh(gridData)
        else
            ResUtil:CreateUIGOAsync("Grid/GridItem",grid2,function (go)
                local lua = ComUtil.GetLuaTable(go)
                lua.SetClickCB(GridClickFunc.OpenInfoSmiple)
                lua.Refresh(gridData)
                CSAPI.SetGOActive(lua.countObj, false);
                gridItem2 = lua
            end)
        end
        local count = gridDatas2[1].num
        CSAPI.SetText(txtCount2,count .. "")
    end
end

function SetState()
    isCanBuy = ShopCommFunc.CheckCanPay(data,1) and not data:IsOver()
    CSAPI.SetGOActive(img_can,isCanBuy and not data:IsOver())
    CSAPI.SetGOActive(img_cannot,not isCanBuy and not data:IsOver())
    CSAPI.SetGOActive(toggle,not data:IsOver())
    CSAPI.SetGOActive(txt_exchange3,data:IsOver())
    CSAPI.SetGOActive(txt_exchange1,not data:IsOver())
    CSAPI.SetGOActive(txt_exchange2,not data:IsOver())

    local infos = FileUtil.LoadByPath("Activity_ExChange_Tip") or {}
    tgl.isOn = infos[data:GetID()] and infos[data:GetID()] == 1 or false

    CSAPI.SetGOAlpha(gameObject,data:IsOver() and 0.6 or 1)
end

function OnClickExchange()
    if not data or data:IsOver() then
        return
    end
    if not isCanBuy then
        LanguageMgr:ShowTips(37001)
        return
    end
    if cb then
        cb(this)
    end
end

function GetData()
    return data
end