local AccuChargeData = require("AccuChargeData")
local this = MgrRegister("AccuChargeMgr")

function this:Init()
    self:Clear()
    self:InitData()
    PlayerProto:GetColletData()
end

function this:Clear()
    self.proto = {}
    self.datas = {}
end

function this:InitData()
    self.datas = {}
    local cfgs = Cfgs.CfgRechargeCount:GetAll()
    for i, v in ipairs(cfgs) do
        local data = AccuChargeData.New()
        data:InitData(v)
        table.insert(self.datas, data)
    end
end

function this:GetDatas()
    return self.datas
end

function this:GetColletDataRet(proto)
    self.proto = proto
    -- EventMgr.Dispatch(EventType.AccuCharge_Get)
    self:CheckRed()
end

function this:CheckRed()
    local num = 0
    for k, v in pairs(self.datas) do
        if (v:IsRed()) then
            num = 1 
            break
        end
    end
    local rData = RedPointMgr:GetData(RedPointType.AccuCharge)
    if(rData==nil or rData~=num) then 
        RedPointMgr:UpdateData(RedPointType.AccuCharge, num)
        ActivityMgr:CheckRedPointData(ActivityListType.AccuCharge)
    end 
end

function this:GetScore()
    local socre = self.proto.score
    if (socre) then
        return math.floor(socre / 100)
    end
    return 0
end

function this:CheckIsGet(id)
    if (self.proto.data) then
        for k, v in pairs(self.proto.data) do
            if (v == id) then
                return true
            end
        end
    end
    return false
end

return this
