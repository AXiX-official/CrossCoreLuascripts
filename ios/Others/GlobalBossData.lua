local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:InitCfg(cfgId)
    self.cfg = Cfgs.cfgGlobalBoss:GetByID(cfgId)
    if self.cfg and self.cfg.dupId then
        self.dungeonCfg = Cfgs.MainLine:GetByID(self.cfg.dupId)
    end
end

function this:GetCfg()
    return self.cfg
end

--副本配置表数据
function this:GetDungeonCfg()
    return self.dungeonCfg
end

function this:GetID()
    return self.cfg and self.cfg.id
end

--最大挑战次数
function this:GetMaxCount()
    return self.cfg and self.cfg.challengeTimes
end

--动效路径名
function this:GetEffectName()
    return self.cfg and self.cfg.spriteWay
end

--图标路径名
function this:GetIcon()
    return self.cfg and self.cfg.BossPreview
end

function this:GetRankType()
    return self.cfg and self.cfg.rankType
end

return this