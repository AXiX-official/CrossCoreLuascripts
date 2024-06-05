--对手信息
local this = {
	data = {},
}

function this.New()
	this.__index = this.__index or this
	local ins = {}
	setmetatable(ins, this)
	return ins
end

function this:InitData(sPracticeObjInfo)
	self.data = sPracticeObjInfo or {}
end

function this:GetID()
	return self.data.uid or nil
end

function this:GetModuleID( )
	return self.data.icon_id or nil
end

function this:GetName()
	return self.data.name or ""
end

function this:GetLevel()
	return self.data.level or "1"
end

--段位
function this:GetRankLevel()
	return self.data.rank_level or 1
end
function this:GetDwName()
	local cfg = Cfgs.CfgPracticeRankLevel:GetByID(self:GetRankLevel())
	return cfg.name or ""
end
function this:GetRank()
	return self.data.rank or 0
end

function this:GetPerformance()
	return self.data.performance or 0
end

function this:GetIconID()
	return self.data.icon_id or nil
end

function this:GetIsRobot()
	return self.data.is_robot
end

--积分
function this:GetScore()
	return self.data.score or 0
end

function this:GetRolePanelID( )
	return self.data.role_panel_id or nil
end

function this:GetFrameId()
	return self.data.icon_frame 
end

return this 