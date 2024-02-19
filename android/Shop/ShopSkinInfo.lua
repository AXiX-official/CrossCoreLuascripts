local this = {}
--皮肤商店使用的皮肤信息
function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
    if cfgId==nil then
        LogError("初始化皮肤信息失败！无效配置id");	
        return
    end
    if self.cfg==nil then
        self.cfg=Cfgs.CfgSkinInfo:GetByID(cfgId);
        if(self.cfg == nil) then		
			LogError("找不到皮肤信息配置！id = " .. cfgId);	
		end
    end
    if self.modelCfg==nil then
        self.modelCfg=Cfgs.character:GetByID(cfgId)
        if(self.modelCfg == nil) then		
			LogError("找不到模型配置！id = " .. cfgId);	
		end
    end
end

function this:GetModelCfg()
    return self.modelCfg
end

function this:GetSkinName()
    return self.modelCfg and self.modelCfg.desc or "";
end

function this:GetRoleName()
    return self.modelCfg and self.modelCfg.key or "";
end

function this:GetModelID()
    return self.modelCfg and self.modelCfg.id or nil;
end

function this:GetSeasonID()
    return self.cfg and self.cfg.season or nil;
end

function this:GetSeasonCfg()
    local sId=self:GetSeasonID();
    if sId~=nil then
        return Cfgs.CfgSkinSeasonEnum:GetByID(sId);
    end
    return nil;
end

function this:GetSetID()
    return self.cfg and self.cfg.setID or nil
end

function this:GetSetCfg()
    local sId=self:GetSetID();
    if sId~=nil then
        return Cfgs.CfgSkinSetInfo:GetByID(sId);
    end
    return nil;
end

function this:GetSort()
    return self.cfg and self.cfg.sort or nil
end

--活动跳转ID，如果有值则跳转到对应界面
function this:GetBuyInfo()
    return self.modelCfg and self.modelCfg.getCondition or nil
end

--获得途径类型和描述
function this:GetWayInfo(isShort)
    --读取跳转表的多语言ID
    local wayType=nil;
    local info=self:GetBuyInfo();
    local wayTips=nil;
    if info~=nil then
        local jumpCfg=Cfgs.CfgJump:GetByID(info[1]);
        if jumpCfg then
            wayTips=LanguageMgr:GetByID(jumpCfg.tag);
            if jumpCfg.tag==18054 then
                wayType=SkinGetType.Archive;
                wayTips=LanguageMgr:GetByID(18054);
            elseif jumpCfg.tag==18053 then
                wayType=SkinGetType.Store
                wayTips=LanguageMgr:GetByID(18053);
            elseif jumpCfg.tag==18055 then
                wayType=SkinGetType.Other;
                wayTips=LanguageMgr:GetByID(18055);
            end
        end
    else
        wayType=SkinGetType.None;
        if isShort then
            wayTips=LanguageMgr:GetByID(18057)
        else
            wayTips=LanguageMgr:GetByID(18056);
        end
    end
    return wayType,wayTips;
end

function this:GetDesc()
    return self.modelCfg and self.modelCfg.model_desc or ""
end

function this:GetSkinDesc()
    return self.modelCfg and self.modelCfg.skin_desc or ""
end

--是否有入场动画
function this:HasEnterTween()
    local has=false
    local modelCfg=self:GetModelCfg();
    if modelCfg and modelCfg.hadAni==1 then
        has=true;
    end
    return has
end

--是否有L2d
function this:HasL2D()
    local has=false
    local modelCfg=self:GetModelCfg();
    if modelCfg and modelCfg.l2dName then
        has=true;
    end
    return has
end

--是否包含模型
function this:HasModel()
    local has=false
    local modelCfg=self:GetModelCfg();
    if modelCfg and modelCfg.hadModel then
        has=modelCfg.hadModel==1;
    end
    return has
end

--是否包含特价标签
function this:HasSpecial()
    local has=false
    local modelCfg=self:GetModelCfg();
    if modelCfg and modelCfg.hadSpecial then
        has=modelCfg.hadSpecial==1;
    end
    return has
end

function this:IsHide()
    return self.cfg and self.cfg.isShow==1 or false;
end

return this;