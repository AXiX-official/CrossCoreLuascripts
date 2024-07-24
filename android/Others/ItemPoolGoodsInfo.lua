--道具池元素信息
local this = {}
function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:SetData(cfg,num,round,isFull)
    self.cfg=cfg;
    self.num=num;
    self.round=round;
    self.isFull=isFull;
end

--是否关键奖励
function this:IsKeyReward()
    return self.cfg and self.cfg.iskeyreward or false;
end

function this:GetRewardNum()
    return self.cfg and self.cfg.rewardnum or 1;
end

function this:GetIndex()
    return self.cfg and self.cfg.index or 0;
end

--返回当前剩余的奖励数量
function this:GetCurrRewardNum()
    local num=0;
    if self.num then
        local max=self:GetRewardNum();
        num=max-self.num;
    elseif self.isFull then
        num=self:GetRewardNum();
    end
    return num;
end

--返回轮次信息，SetData之后才能正常得到
function this:GetRound()
    if self.round then
        return self.round;
    end
    return 1;
end

function this:GetIndex()
    return self.cfg and self.cfg.index or 1;
end

--返回奖励道具信息
function this:GetGoodInfo()
    if self.cfg and self.cfg.reward then
        local cfgId=self.cfg.reward[1];
        local num=self.cfg.reward[2];
        local goods=GoodsData({id=cfgId,num=num});
        return goods;
    end
    return nil;
end

return this;