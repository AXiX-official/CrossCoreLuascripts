local leftInfos = {{70004,"GlobalBoss/btn_04_01"},{70005,"GlobalBoss/btn_04_02"},{70006,"GlobalBoss/btn_04_01"},{70007,"GlobalBoss/btn_04_01"}}
local viewPaths = {"GlobalBossKillReward","GlobalBossRank","GlobalBossRankReward","GlobalBossFightReward"}
local panels = {}
local curPanel = nil
local cfg = nil
curIndex1,curIndex2 = 1,1

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.GlobalBoss_Data_Update,OnDataUpdate)
end

function OnDataUpdate(isOffset)
    if isOffset then
        local dialogData = {}
        dialogData.content = LanguageMgr:GetTips(47003)
        dialogData.okCallBack = function()
            UIUtil:ToHome()
        end
        CSAPI.OpenView("Prompt",dialogData)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("GloaBossListView", topParent, OnClickReturn);
end

function OnOpen()
    if openSetting and openSetting> 0 then
        curIndex1 = openSetting
    end
    InitCfg()
    InitLeftPanel()
    RefreshPanel()
end

function InitCfg()
    if data and data.id then
        cfg = Cfgs.cfgGlobalBoss:GetByID(data.id)
    end
end

function InitLeftPanel()
    if(not leftPanel) then
		local go = ResUtil:CreateUIGO("Common/LeftPanel", leftParent.transform)
		leftPanel = ComUtil.GetLuaTable(go)
	end
	leftPanel.Init(this, leftInfos, nil, 140)
end

function RefreshPanel()
    if cfg == nil then
        return
    end

    leftPanel.Anim()
    if curPanel then
        local go = curPanel.gameObject
        UIUtil:SetObjFade(go,1,0,function ()
            CSAPI.SetGOActive(go,false)
        end,400)
        FuncUtil:Call(ShowPanel,this,200)
    else
        ShowPanel()
    end
end

function ShowPanel()
    local index = curIndex1
    if panels[index] then
        CSAPI.SetGOActive(panels[index].gameObject,true)
        UIUtil:SetObjFade(panels[index].gameObject,0,1,nil,400)
        if panels[index].Refresh then
            panels[index].Refresh(cfg)
        end
        curPanel = panels[index]
    elseif viewPaths[index] then  
        ResUtil:CreateUIGOAsync("GlobalBoss/" ..viewPaths[index],viewParent,function (go)
            local lua = ComUtil.GetLuaTable(go)
            if lua.Refresh then
                lua.Refresh(cfg)
            end
            panels[index] = lua
            curPanel = lua
            UIUtil:SetObjFade(go,0,1,nil,400)
        end)
    end
end

function OnClickReturn()
    view:Close()
end