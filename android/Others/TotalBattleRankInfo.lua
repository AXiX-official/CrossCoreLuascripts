local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:Init(info)
    self.info = info
end

function this:GetRank()
    return self.info and self.info.rank
end

function this:GetName()
    return self.info and self.info.name
end

function this:GetLevel()
    return self.info and self.info.level
end

function this:GetScore()
    return self.info and self.info.score or ""
end

function this:GetIconID()
    return  self.info and self.info.icon_id
end

function this:GetFrameId()
    return self.info and self.info.icon_frame
end

function this:GetSex()
    return self.info and self.info.sel_card_ix or 1
end

function this:GetPassName()
    if self.info and self.info.dupId and self.info.dupId > 0 then
        local cfg = Cfgs.MainLine:GetByID(self.info.dupId)
        return cfg and cfg.chapterID or ""
    end
    return ""
end

return this