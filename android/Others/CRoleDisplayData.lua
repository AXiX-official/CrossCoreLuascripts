local this = {}
function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:InitIndex(index)
    self.index = index
    -- 默认数据
    self.sNewPanel = {}
    self.sNewPanel.idx = index
    self.sNewPanel.ids = self:IsTwoRole() and {0, 0} or {0}
    self.sNewPanel.bg = 1
    self.sNewPanel.detail1 = {
        live2d = false,
        x = 0,
        y = 0,
        scale = 1,
        top = false
    }
    if (self:IsTwoRole()) then
        self.sNewPanel.detail2 = {
            live2d = false,
            x = 0,
            y = 0,
            scale = 1,
            top = false
        }
    end
end

function this:IsTwoRole()
    return self.index == 6
end

-- 服务器数据
function this:InitRet(_sNewPanel)
    self.sNewPanel = _sNewPanel
end

function this:GetIndex()
    return self.index
end
function this:GetRet()
    return self.sNewPanel
end

function this:GetIDs()
    if (self.sNewPanel) then
        return self.sNewPanel.ids
    else
        return self.index == 6 and {0, 0} or {0}
    end
end

function this:CheckOpen()
    if (g_BulletinBoardOpen[self.index] ~= 0) then
        local _id = g_BulletinBoardOpen[self.index]
        local _isOpen, lockStr = MenuMgr:CheckConditionIsOK({_id})
        if (not _isOpen) then
            return false, lockStr
        end
    end
    return true, ""
end

-- 是否有角色
function this:CheckIsEntity()
    local ids = self:GetIDs()
    for k, v in pairs(ids) do
        if (v ~= 0) then
            return true
        end
    end
    return false
end

-- -- 槽位皮肤能否使用（皮肤未获得就不能保存）
-- function this:SetCanUse(slot, b)
--     self.slotCanUse = self.slotCanUse or {}
--     self.slotCanUse[slot] = b
-- end
-- function this:GetCanUse(slot)
--     self.slotCanUse = self.slotCanUse or {}
--     return self.slotCanUse[slot]
-- end

-- 皮肤能否使用
function this:GetCanUse(slot)
    local id = self:GetIDs()[slot]
    if (id ~= 0) then
        if (id < 10000) then
            local _data = MulPicMgr:GetData(id)
            if (_data == nil or not _data:IsHad()) then
                return false
            end
        else
            local _data = RoleSkinMgr:GetSkinInfoByModelID(id)
            if (_data == nil or not _data:CheckCanUse()) then
                return false
            end
        end
    end
    return true
end

-- 皮肤或者多人插图是否和谐中
function this:CheckIsHX(slot)
    local id = self:GetIDs()[slot]
    if (id ~= nil and id ~= 0) then
        if (id < 10000) then
            local cfg = Cfgs.CfgArchiveMultiPicture:GetByID(id)
            return cfg.img_replace ~= nil
        else
            local cfg1 = Cfgs.character:GetByID(id)
            local cfg2 = cfg1.shopId and Cfgs.CfgCommodity:GetByID(cfg1.shopId) or nil
            if (cfg2 and cfg2.isShowImg == 1) then
                return true
            end
        end
    end
    return false
end

-- 显示和谐的图
function this:IsShowShowImg(slot)
    if (not self:GetCanUse(slot) and self:CheckIsHX(slot)) then
        return true
    end
    return false
end

-- 是否有l2d
function this:HadL2D(slot)
    local id = self:GetIDs()[slot]
    if (id ~= nil and id ~= 0) then
        if (id < 10000) then
            local cfg = Cfgs.CfgArchiveMultiPicture:GetByID(id)
            if (cfg and cfg.l2dName) then
                return true
            end
        else
            local cfg = Cfgs.character:GetByID(id)
            if (cfg and cfg.l2dName) then
                return true
            end
        end
    end
    return false
end

-- 是否显示l2d的按钮,没有/在底层/和谐中 不会显示
function this:ShowBtnL2D(slot)
    if (not self:HadL2D(slot) or not self:GetRet()["detail" .. slot].top) then
        return false
    end
    if (self:GetCanUse(slot)) then
        return true
    end
    if (self:HadL2D(slot) and self:GetRet()["detail" .. slot].top and not self:CheckIsHX(slot)) then
        return true
    end
    return false
end

-- {[id] =1,[id] =2} 
function this:GetRealIDsDic()
    local idsDic, len = {}, 0
    local ids = self:GetIDs()
    for k, v in ipairs(ids) do
        if (v ~= 0) then
            idsDic[v] = k
            len = len + 1
        end
    end
    return idsDic, len
end

-- function this:GetRealRoleIDsDic()
--     local idsDic, len = {}, 0
--     local ids = self:GetIDs()
--     for k, v in ipairs(ids) do
--         if (v ~= 0) then
--             local role_id = Cfgs.character:GetByID(k).role_id
--             idsDic[role_id] = k
--             len = len + 1
--         end
--     end
--     return idsDic, len
-- end

-- 选择一个角色时
function this:InitDetail(slot, id)
    self:GetRet().ids[slot] = id
    local isTop = true
    if (self:IsTwoRole()) then
        local _slot = slot == 1 and 2 or 1
        if (self:GetRet().ids[_slot] ~= 0) then
            if (slot == 1 and self:GetRet().detail2.top) then
                isTop = false
            elseif (slot == 2 and self:GetRet().detail1.top) then
                isTop = false
            end
        else
            self:GetDetail(_slot).top = false
        end
    end
    local isLive2d = false
    if (isTop and self:HadL2D(slot)) then
        if(self:GetCanUse(slot)) then 
            isLive2d = true
        elseif(not self:CheckIsHX(slot)) then 
            isLive2d = true
        end
    end

    if (slot == 1) then
        self:GetRet().detail1 = {
            live2d = isLive2d,
            scale = 1,
            x = 0,
            y = 0,
            top = isTop
        }
    else
        self:GetRet().detail2 = {
            live2d = isLive2d,
            scale = 1,
            x = 0,
            y = 0,
            top = isTop
        }
    end
end

-- 移除一个后重新更新top
function this:InitTop()
    if (self:IsTwoRole()) then
        local slot = 1
        if (self:GetIDs()[1] ~= 0 or (self:GetIDs()[2] ~= 0)) then
            slot = self:GetIDs()[1] ~= 0 and 1 or 2
        end
        local elseSlot = slot == 1 and 2 or 1
        self:GetRet()["detail" .. slot].top = true
        self:GetRet()["detail" .. elseSlot].top = false
    end
end

function this:GetDetail(slot)
    return self:GetRet()["detail" .. slot]
end

function this:GetTopSlot()
    return self:GetDetail(1).top and 1 or 2
end

function this:GetBG()
    return self:GetRet().bg or 1
end

return this
