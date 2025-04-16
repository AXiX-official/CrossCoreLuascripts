SpecialGuideMgr = MgrRegister("SpecialGuideMgr")
local this = SpecialGuideMgr;

function this:Init()
    self:Clear()
    self:InitCfgs()
end

function this:InitCfgs()
    -- local _cfgs = Cfgs.SpecialGuide:GetAll()
    -- if _cfgs then
    --     for k, cfg in pairs(_cfgs) do
    --         if cfg.viewName then
    --             self.cfgs[cfg.viewName] = self.cfgs[cfg.viewName] or {}
    --             table.insert(self.cfgs[cfg.viewName],cfg)
    --         end
    --     end
    -- end
end

--根据和条件比对去触发函数
function this:TryCallFunc(viewName,funcName,datas)
    -- if viewName == nil or viewName == "" then
    --     return
    -- end
    -- if GuideMgr:HasGuide(viewName) or GuideMgr:IsGuiding() or self:IsClose() then
    --     return
    -- end
    -- local cfgs = self.cfgs[viewName]
    -- if cfgs and #cfgs > 0 then
    --     local need,max =0,0
    --     for _, cfg in ipairs(cfgs) do
    --         if cfg.info then
    --             need,max = 0,0
    --             for k, v in pairs(cfg.info) do
    --                 if datas and datas[k] and datas[k] == v then
    --                     need = need + 1
    --                 end
    --                 max = max + 1
    --             end
    --             if need == max and cfg.id and this[funcName] then
    --                 this[funcName](this,cfg.id)
    --             end
    --         elseif this[funcName] and cfg.id then
    --             this[funcName](this,cfg.id)
    --         end
    --     end
    -- end
end

--开始检测
function this:Start(id)
    -- LogError(id)
    -- LogError(self.info)
    local cfg = Cfgs.SpecialGuide:GetByID(id)
    if cfg == nil or cfg.time == nil then
        return
    end
    if self.info[id] and self.info[id].isShow then
        return
    end
    local time = cfg.time + TimeUtil:GetTime()
    if self:IsShow(id) then --已经显示
        time = TimeUtil:GetTime() - 1
    end
    self.info[id] = {
        time = time,
        cfg = cfg,
    }
end


--显示
function this:Show(id)
    if self.info[id] and not self.info[id].isShow and TimeUtil:GetTime() > self.info[id].time then
        self.info[id].isShow = true
        CSAPI.OpenView("SpecialGuide",nil,nil,function (go)
            local lua = ComUtil.GetLuaTable(go)
            if lua and self.info and self.info[id] and self.info[id].isShow then
                lua.Show(id)
            end
        end)
        self:SetShow(id,true)
    end
end 

--停止所有
function this:StopAll()
    -- for k, v in pairs(self.info) do
    --     self:Stop(k)
    -- end
end

--停止
function this:Stop(id)
    if self.info[id] then 
        if CSAPI.IsViewOpen("SpecialGuide") then
            local viewGo = CSAPI.GetView("SpecialGuide")
            if not IsNil(viewGo) then
                local view = ComUtil.GetLuaTable(viewGo)
                if view and view.Hide and self.info and self.info[id] and self.info[id].isShow then
                    view.Hide(id)
        end
            end
        end
        self.info[id] = nil
    end
end

--完成
function this:TryFinish(id)
    if self.info[id] then
        if self.info[id].isShow then
            self:Finish(id)
        else --刷新
            self.Start(id)
        end
    end
end

--完成
function this:Finish(id)
    if self.info[id] then
        if self.info[id].isShow then
            self:SetShow(id,false)
        end
        self:Stop(id)
    end
end

function this:Update()
    -- if self.timer < Time.time then
    --     self.timer = Time.time + 1
    --     for k, v in pairs(self.info) do
    --         self:Show(k)
    --     end
    -- end
end

function this:SetShow(id,b)
    self.showInfos[id] = b
end

function this:IsShow(id)
    return self.showInfos[id]
end

function this:CloseView()
    -- self:StopAll()
    -- if CSAPI.IsViewOpen("SpecialGuide") then
    --     local go = CSAPI.GetView("SpecialGuide")
    --     if not IsNil(go) then
    --         local view = ComUtil.GetLuaTable(go)
    --         if view and view.CloseView then
    --             view.CloseView()
    --         end
    --     end
    -- end
end

function this:IsClose()
    -- local dungeonData = DungeonMgr:GetDungeonData(g_SpecialGuideCondition)
    -- if dungeonData and dungeonData:IsPass() then
        return true
    -- end
    -- return false
end

function this:Clear()
    self.showInfos = {}
    self.cfgs = {}
    self.info = {}
    self.view = nil
    self.timer = 0
end

return this