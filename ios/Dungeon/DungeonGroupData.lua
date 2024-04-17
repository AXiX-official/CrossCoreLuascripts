local this = {};

function this.New()
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    return ins;
end

function this:Init(cfg, isHard)
    self.cfg = cfg
    self.isHard = false
end

-- 设置困难
function this:SetHard(b)
    self.isHard = b
end

function this:GetCfg()
    return self.cfg
end

function this:GetID()
    return self.cfg and self.cfg.id
end

function this:GetName()
    return self.cfg and self.cfg.name
end

function this:GetGroup()
    return self.cfg and self.cfg.group
end

function this:GetPos()
    if self.cfg then
        local x = self.cfg.x or 0
        local y = self.cfg.y or 0
        return {x = x, y = y}
    end
    return {0, 0}
end

--按钮离中心点相对位置
function this:GetRelativePos()
    return self.cfg and self.cfg.relativePos
end

--线段转折点
function this:GetTurnPos()
    return self.cfg and self.cfg.turnPos
end

-- 返回包含副本关卡 isHard:困难模式
function this:GetDungeonGroups()
    if self.cfg then
        return self.isHard and self.cfg.hDungeonGroups or self.cfg.dungeonGroups
    end
    return nil
end

--获取星数
function this:GetStar()
    local groups = self:GetDungeonGroups()
    local cur,max = 0,0
    if groups and #groups > 0 then
        for k, v in ipairs(groups) do
            local dungeonData = DungeonMgr:GetDungeonData(v)
            if dungeonData and not dungeonData:IsStory() then
                cur = cur + dungeonData:GetStar()              
            end
            local cfgDungeon = Cfgs.MainLine:GetByID(v)
            if cfgDungeon and not cfgDungeon.sub_type then --关卡总星数
                max = max + 3 
            end
        end   
    end

    return cur,max
end

--获取通关数
function this:GetPassCount()
    local groups = self:GetDungeonGroups()
    local cur,max = 0,0
    if groups and #groups > 0 then
        for k, v in ipairs(groups) do
            local dungeonData = DungeonMgr:GetDungeonData(v)
            if dungeonData and dungeonData:IsPass() then
                cur = cur + 1
            end
        end
        max = #groups
    end

    return cur,max
end

-- 返回当前是否开启
function this:IsOpen()
    local groups = self:GetDungeonGroups()
    if groups and #groups > 0 then
        return DungeonMgr:IsDungeonOpen(groups[1])
    end
    return false
end

-- 返回当前是否通关
function this:IsPass()
    local groups = self:GetDungeonGroups()
    if groups and #groups > 0 and DungeonMgr:IsDungeonOpen(groups[1]) then
        local count = 0
        for _, id in ipairs(groups) do
            local dungeonData = DungeonMgr:GetDungeonData(id)
            if dungeonData and dungeonData:IsPass() then
                count = count + 1
            end
        end
        if count == #groups then
            return true
        end
    end
    return false
end

-- 返回当前最新状态 isHard:困难模式
function this:IsCurrNew()
    return self:IsOpen() and not self:IsPass()
end

--困难
function this:IsHard()
    return self.isHard
end

-----------------------------------------------plot-----------------------------------------------

function this:GetTargetJson()
    return self.cfg and self.cfg.target
end

-----------------------------------------------TaoFa-----------------------------------------------
function this:GetBGPath()
    local name = self.cfg and self.cfg.bg or ""
    if name ~= "" then
        return "UIs/DungeonActivity/TaoFa/" .. name .."/bg"
    end
    return nil
end

function this:GetVideoName()
    return self.cfg and self.cfg.video
end

function this:GetImgPath()
    local name = self.cfg and self.cfg.img or ""
    if name ~= "" then
        return "UIs/DungeonActivity/TaoFa/" .. name .."/img"
    end
    return nil 
end

function this:GetShowType()
    return self.cfg and self.cfg.showType or 1
end

return this;
