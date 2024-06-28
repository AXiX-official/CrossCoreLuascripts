--活动副本开启

local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:Init(_data)
    self.data = _data
    if self.data then
        self.openCfg = Cfgs.CfgActiveEntry:GetByID(self.data.id)
        if self.openCfg and self.openCfg.config and self.openCfg.nConfigID then
            self.cfg = Cfgs[self.openCfg.config]:GetByID(self.openCfg.nConfigID)
        end
    end
end

function this:GetData()
    return self.data
end

--开启相关配置
function this:GetOpenCfg()
    return self.openCfg
end

--关联配置
function this:GetCfg()
    return self.cfg
end

--活动开启
function this:IsOpen()
    if self.data and self.data.nBegTime and self.data.nEndTime then
        local time = TimeUtil:GetTime()
        return time > self.data.nBegTime and time <= self.data.nEndTime
    end
    return false
end

--副本开启
function this:IsDungeonOpen()
    if self.data and self.data.nBegTime and self.data.nBattleendTime then
        return TimeUtil:GetTime() >= self.data.nBegTime and TimeUtil:GetTime() < self.data.nBattleendTime,LanguageMgr:GetTips(24003)
    end
    return false,""
end

--困难本开启
function this:IsHardOpen()
    local timeStr = ""
    if self.openCfg and self.openCfg.hardBegTime then
        timeStr = self.openCfg.hardBegTime
    end
    if self.data and self.data.nHardBegTime and self:IsDungeonOpen()  then
        local tips = LanguageMgr:GetTips(24007, timeStr)
        return TimeUtil:GetTime() >= self.data.nHardBegTime,tips
    end
    return false,""
end

--EX本开启
function this:IsExtreOpen()
    local timeStr = ""
    if self.openCfg and self.openCfg.exBegTime then
        timeStr = self.openCfg.exBegTime
    end
    if self.data and self.data.nExBegTime and self:IsDungeonOpen() then
        local tips = LanguageMgr:GetTips(24007, timeStr)
        return TimeUtil:GetTime() >= self.data.nExBegTime,tips
    end
    return false,""
end

function this:GetTimeStrs()
    local strs = {}
    if self.cfg and self.cfg.actionTime  then
        local s1 = StringUtil:split(self.cfg.actionTime,"-")
        if #s1>1 then
            local s2 = StringUtil:split(s1[1]," ")
            if #s2 > 1 then
                table.insert(strs,s2[1])
                table.insert(strs,s2[2])
            end
            local s3 = StringUtil:split(s1[2]," ")
            if #s3 > 1 then
                table.insert(strs,s3[1])
                table.insert(strs,s3[2])
            end
        end
    end
    return strs
end

function this:GetCloseTimeStr()
    return self.cfg and self.cfg.actionCloseTime or ""
end

function this:GetName()
    return self.cfg and self.cfg.name or ""
end

function this:GetShopID()
    return self.cfg and self.cfg.shopID
end

function this:GetHardTime()
    return self.data and self.data.nHardBegTime
end

--获取剩余时间
function this:GetEndTime()
    return self.data and self.data.nEndTime or 0
end

function this:GetSectionID()
    return self.cfg and self.cfg.sectionID
end

return this 