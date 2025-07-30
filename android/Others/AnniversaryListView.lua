local items2 = nil
local datas = nil
local curIndex = 1
local selIndex = 0
local refreshTime = 0
local time = 0
local timer = 0
local rightItems = {}
local curItemR = nil

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Update_Everyday, OnDayRefresh)
    eventMgr:AddListener(EventType.RedPoint_Refresh,OnRedPointRefresh)

    CSAPI.SetGOActive(animMask, false)
end

function OnDayRefresh()
    UIUtil:ToHome()
end

function OnRedPointRefresh()
    SetLeft()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("AnniversaryList", topParent, OnClickBack)
end

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = refreshTime - TimeUtil:GetTime()
        if time <= 0 then
            SetTime()
            SetDatas()
            SetLeft()
        end
    end
end

function OnOpen()
    SetDatas()
    SetTime()
    SetJumpState()
    SetLeft()
end

function SetDatas()
    local group = AnniversaryType.Timest
    if data and data.group then
        group = tonumber(data.group)
    end
    datas = AnniversaryMgr:GetArr(group)
end

function SetTime()
    refreshTime = AnniversaryMgr:GetNextRefreshTime()
    time = refreshTime - TimeUtil:GetTime()
end

function SetJumpState()
    if data and data.jumpId and #datas > 0 then
        for i, v in ipairs(datas) do
            if v:GetID() == data.jumpId then
                curIndex = i
                break
            end
        end
    end
end

function SetLeft()
    items2 = items2 or {}
    ItemUtil.AddItems("AnniversaryList/AnniversaryListItem",items2,datas,itemParent2,OnItemClickCB,1,nil,OnFirstShow)
end

function OnItemClickCB(item)
    if item.index == selIndex then
        return
    end

    if items2[selIndex] then
        items2[selIndex].SetSelect(false)
        items2[selIndex].ShowSelAnim()
    end

    curIndex = item.index
    selIndex = item.index
    item.SetSelect(true)
    item.ShowSelAnim()
    SetRight()
end

function OnFirstShow()
    if not isFirst then
        isFirst = true
        if items2 and #items2 > 0 then
            for i, v in ipairs(items2) do
                if v.gameObject.activeSelf then
                    v.PlayEnterAnim()
                end
            end
        end
    end
    if items2 and items2[curIndex] then
        items2[curIndex].OnClick()
    end
end

function SetRight()
    if (curItemR) then
        PlayAnim(200)
        UIUtil:SetObjFade(curItemR.gameObject, 1, 0, function()
            CSAPI.SetGOActive(curItemR.gameObject, false)
            curItemR = nil
            ShowRight()
        end, 200)
    else
        ShowRight()
    end
end

function ShowRight()
    local _data = datas[curIndex]
    if _data then
        PlayAnim(200)
        local _elseData = GetElseData(_data)
        if (rightItems[_data:GetID()]) then
            CSAPI.SetGOActive(rightItems[_data:GetID()].gameObject, true)
            rightItems[_data:GetID()].Refresh(_data, _elseData)
            UIUtil:SetObjFade(rightItems[_data:GetID()].gameObject, 0, 1, nil, 200)
            curItemR = rightItems[_data:GetID()]
        else
            if (_data:GetPath()) then
                ResUtil:CreateUIGOAsync(_data:GetPath(), itemParent, function(go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.Refresh(_data, _elseData)
                    UIUtil:SetObjFade(go, 0, 1, nil, 200)
                    rightItems[_data:GetID()] = lua
                    curItemR = lua
                end)
            else
                LogError("找不到对应位置的预设体！！！" .. _data:GetID())
            end
        end
    end
end

function GetElseData(_data)
    return nil
end

function PlayAnim(time)
    CSAPI.SetGOActive(animMask, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(animMask, false)
    end, this, time)
end

function OnClickBack()
    view:Close()
end
