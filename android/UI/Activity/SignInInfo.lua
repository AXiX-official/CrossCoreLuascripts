--单个活动
local this = {}

function this.New()
	local ins = {}
	this.__index = this.__index or this
	setmetatable(ins, this)
	return ins
end

function this:InitData(key, proto)
	self.key = key
	self.proto = proto
end

--混合key
function this:GetKey()
	return self.key
end

--签到表id
function this:GetID()
	return self.proto.id
end

--签到表某id的index
function this:GetIndex()
	return self.proto.index
end

--签到记录
function this:GetRewardsInfos()
	return self.proto.rewardsInfos
end

--更新记录
function this:SetRewardsInfos(rewardsInfos)
	self.proto.rewardsInfos = rewardsInfos
end

--签到表
function this:GetCfg()
	return Cfgs.CfgSignReward:GetByID(self:GetID())
end

--奖励表
function this:GetRewardCfg()
	local cfg = self:GetCfg()
	local rewardCfgID = cfg.infos[self:GetIndex()].activityRewardId
	return Cfgs.CfgSignRewardItem:GetByID(rewardCfgID)
end

function this:GetSortIndex()
	return self:GetCfg() and self:GetCfg().sortIndex or 0
end

--活动在当天是否已签 （根据最后签到时间来检测）
function this:CheckIsDone()
	--如果已经签到过
	if(SignInMgr:CurDayIsOpen(self.key)) then
		return true
	end
	
	--如果当天不存在签到，默认已签到
	if(not self:CurDayIsExit()) then
		return true
	end
	
    local rewardsInfos = self:GetRewardsInfos();
	local time = rewardsInfos and rewardsInfos.lastSingTime 
	if(time) then
		time = time + TimeUtil:GetTZDiffTime()
		--是否是当天
		local curTime = TimeUtil:GetBJTime()
		if(curTime - time >= 86400) then
			return false
		else
			local oldDay = SignInMgr:GetCurDay(time)
			local curDay = SignInMgr:GetCurDay()
			return oldDay == curDay
		end
	else
		return false
	end
end

--当天是否存在签到
function this:CurDayIsExit(curDay)
	curDay = curDay ~= nil and curDay or SignInMgr:GetCurDay()
	local rewardCfg = self:GetRewardCfg()
	if(self:GetType() == RewardActivityType.DateDay) then
		return #rewardCfg.infos >= curDay
	elseif(self:GetType() == RewardActivityType.DateMonth) then
		return false
	elseif(self:GetType() == RewardActivityType.Continuous) then
		local infos = self:GetRewardsInfos().indexs or {}
		return #rewardCfg.infos > #infos
	end
	return false
end

--[[RewardActivityType = {
	DateDay = 1, -- 月份日期类型
	DateMonth = 2, -- 天数日期类型
	Continuous = 3 -- 连续类型
}
]]
function this:GetType()
	return self:GetCfg().type
end

--活动是否在有效时间段内
function this:CheckInTime()
	local cfg = self:GetCfg()
	if cfg and not cfg.begTime and not cfg.endTime then
		return true
	end
	local begTime = TimeUtil:GetTimeStampBySplit(cfg.begTime)
	local entTime = TimeUtil:GetTimeStampBySplit(cfg.endTime)
	local curTime = TimeUtil:GetTime()
	if(curTime >= begTime and curTime <= entTime) then
		return true
	end
	return false
end

--检测某index是否已签
function this:CheckIndexIsDone(index)
	local indexs = self:GetRewardsInfos().indexs
	if(indexs[index]) then
		return true
	end
	return false
end

--连续签到，当前第几天
function this:GetRealDay()
	local indexs = self:GetRewardsInfos().indexs
	local realDay = #indexs
	if(not self:CheckIsDone()) then
		realDay = realDay + 1
	end
	return realDay
end

function this:GetActivityID()
	return self:GetCfg() and self:GetCfg().activityID
end

return this 