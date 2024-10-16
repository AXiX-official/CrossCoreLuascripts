local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:Init(_id)
    self.cfg = Cfgs.CfgMusic:GetByID(_id)
    -- 
    self:SetFirstLastIDs()
    --
    self.isCanL = self.firstID ~= self.cfg.id
    self.isCanR = self.lastID ~= self.cfg.id
    self.isSetViewBgm = self.cfg.id == BGMMgr:GetViewMusicID()
    self.isCanSetViewBgm = false
    if (self.cfg.music_type == 1 or self.cfg.music_type == 3) then
        self.isCanSetViewBgm = true
    end
end

function this:SetFirstLastIDs()
    local cfgs = Cfgs.CfgMusic:GetGroup(self.cfg.group)
    self.firstID = cfgs[1].id
    self.lastID = cfgs[#cfgs].id
end

function this:GetCfg()
    return self.cfg
end

function this:GetPer()
    local cfgs = Cfgs.CfgMusic:GetGroup(self.cfg.group)
    for k, v in ipairs(cfgs) do
        if (v.id == self.cfg.id) then
            return cfgs[k - 1].id
        end
    end
end

function this:GetNext()
    local cfgs = Cfgs.CfgMusic:GetGroup(self.cfg.group)
    for k, v in ipairs(cfgs) do
        if (v.id == self.cfg.id) then
            return cfgs[k + 1].id
        end
    end
end

return this
