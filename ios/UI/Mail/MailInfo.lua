--邮件信息
local this = {
	id = nil,
	cfgid = 0,
	is_read = 1,
	is_get = 1,
	from_uid = nil,
	start_time = 0,
	end_time = 0,
	name = "",
	from = "",
	desc = "",
	rewards = nil,
}

function this.New()
	this.__index = this.__index or this
	local ins = {}
	setmetatable(ins, this)
	return ins
end

function this:InitData(sMailInfo)
	self.id = sMailInfo.id
	self.is_read = sMailInfo.is_read
	self.is_get = sMailInfo.is_get
	self.from_uid = sMailInfo.from_uid
	self.start_time = sMailInfo.start_time
	self.end_time = sMailInfo.end_time
	self.cfgid = sMailInfo.cfgid
	if(self.cfgid == 0) then
		self.name = sMailInfo.data and sMailInfo.data.name or ""
		self.from = sMailInfo.data and sMailInfo.data.from or ""
		if(sMailInfo.data and sMailInfo.data.desc) then
			self.desc = string.gsub(sMailInfo.data.desc, "<br>", "\n")
		else
			self.desc = ""
		end
		self.rewards = sMailInfo.data and sMailInfo.data.rewards or nil
	else
		local cfg = Cfgs.CfgMail:GetByID(self.cfgid)
		if(cfg) then
			self.name = cfg.name
			self.from = cfg.from
			self.desc = cfg.desc
			self.rewards = sMailInfo.data and sMailInfo.data.rewards or nil
			if(cfg.rewards) then
				self.rewards = self.rewards or {}
				for i, v in ipairs(cfg.rewards) do
					table.insert(self.rewards, {id = v[1], num = v[2], type = v[3]})
				end
			end
		end
	end
	self.sortIndex = nil
end

function this:GetID()
	return self.id
end

function this:GetCfgID()
	return self.cfgid
end

function this:GetUID()
	return self.from_uid
end

function this:StartTime(more)
	if(self.start_time == 0) then
		return ""
	else
		local str = TimeUtil:GetTimeHMS(self.start_time)
		if(more) then
			local hour = str.hour < 10 and "0" .. str.hour or str.hour
			local min = str.min < 10 and "0" .. str.min or str.min
			return string.format("%s.%s.%s %s:%s", str.year, str.month, str.day, hour, min)
		else
			return string.format("%s/%s/%s", str.year, str.month, str.day)
		end
	end
end

function this:EndTime()
	if(self.end_time == 0) then
		return ""
	else
		local strs = TimeUtil:GetTimeTab(self.end_time - TimeUtil:GetTime())
		local str = ""
		if strs[1] > 0 then
			local day = StringUtil:SetByColor(strs[1], "ffc146")
			str = string.format("%s%s", day, LanguageMgr:GetByID(11010))
		elseif strs[2] > 0 then
			local hour = StringUtil:SetByColor(strs[2], "ffc146")
			str = string.format("%s%s", hour, LanguageMgr:GetByID(11009))
		elseif strs[3] > 0 then
			local min = StringUtil:SetByColor(strs[3], "ffc146")
			str = string.format("%s%s", min, LanguageMgr:GetByID(11011))
		else
			local min = StringUtil:SetByColor("1", "ffc146")
			str = string.format("%s%s", min, LanguageMgr:GetByID(11011))
		end
		return LanguageMgr:GetByID(11008, str)
	end
end

--是否已过期
function this:IsEnd()
	if(self.end_time ~= 0 and TimeUtil:GetTime() >= self.end_time) then
		return true
	end
	return false
end

function this:GetName()
	return self.name or ""
end

function this:GetFrom()
	return self.from or ""
end

function this:Desc()
	return self.desc or ""
end

function this:GetIsRead()
	return self.is_read
end

function this:GetIsGet()
	return self.is_get
end

function this:GetRewards()
	return self.rewards
end

--------------------------------set
function this:SetIsRead(_is_read)
	self.is_read = _is_read
end
function this:SetIsGet(_is_get)
	self.is_get = _is_get
end


return this 