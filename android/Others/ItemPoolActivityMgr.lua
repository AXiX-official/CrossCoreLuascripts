--道具池活动管理类
local this = MgrRegister("ItemPoolActivityMgr")

function this:Init()
    self:Clear()
    -- 道具池信息初始化
    RegressionProto:ItemPoolInfo()
end

function this:UpdatePoolInfo(proto)
    if proto and proto.info then
        self.poolInfos=self.poolInfos or {};
        for k,v in ipairs(proto.info) do
            local info=ItemPoolInfo.New();
            info:SetData(v);
            self.poolInfos[info:GetID()]=info;
        end
    else
        self.poolInfos=nil;
    end
end

function this:OnDrawRet(proto)
    if proto and proto.info then
        local info=ItemPoolInfo.New();
        info:SetData(proto.info);
        self.poolInfos=self.poolInfos or {};
        self.poolInfos[info:GetID()]=info;
    end
end

function this:GetPoolInfo(id)
    if self.poolInfos~=nil and self.poolInfos[id] then
        return self.poolInfos[id]
    end
    local info=ItemPoolInfo.New();
    info:InitCfg(id);
    return info;
end

function this:Clear()
    self.poolInfos=nil;
end

return this;