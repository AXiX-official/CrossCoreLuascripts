local items = {}
local cfgs = nil

function OnOpen()
    InitCfgs()
    -- if data then
    --     if openSetting ~= nil then
    --         Show(data)
    --     else
    --         Hide(data)
    --     end
    -- end
end

function InitCfgs()
    if cfgs == nil then
        cfgs = {}
        local _cfgs = Cfgs.SpecialGuide:GetAll()
        if _cfgs then
            for _, cfg in pairs(_cfgs) do
                cfgs[cfg.id] = cfg
            end
        end
    end
end

function Show(id)
    if not cfgs[id] then
        return
    end
    if items[id] then
        CSAPI.SetGOActive(items[id].gameObject, true)
        items[id].Refresh(cfgs[id])
    elseif cfgs[id].name then
        ResUtil:CreateUIGOAsync("SpecialGuide/" .. cfgs[id].name,itemParent,function (go)
            local lua = ComUtil.GetLuaTable(go)
            lua.Refresh(cfgs[id])
            items[id] = lua
        end)
    end
end

function Hide(id)
    if items[id] then
        CSAPI.SetGOActive(items[id].gameObject,false)
    end
end

function CloseView()
    for k, v in pairs(items) do
        CSAPI.SetGOActive(v.gameObject,false)
    end
    if view and view.Close then
        view:Close()
    end
end