--格子视图数据基类
local this=oo.class(GridDataBase);

--data格式：{
--  id,
-- cfg,
-- 	icon,
-- 	quality,
-- 	iconScale,
-- 	iconLoader,
-- 	lv,
-- 	count,
-- 	stars,
-- 	isNew,
-- 	isLock,
--  desc,
--  type,--RandRewardType
-- }
function this:Init(_d)
	self.data=_d;
end

function this:GetName()
	local name="";
	if self.data and self.data.name then
		name=self.data.name;
	end
	return name;
end

function this:GetCfg()
	return self.data and self.data.cfg or nil;
end

function this:GetData()
	return self.data or nil;
end

function this:GetID()
	return self.data and self.data.id or nil;
end

function this:GetIcon()
	local icon=nil;
	if self.data and self.data.icon then
		icon=self.data.icon;
	end
	return icon;
end

function this:GetQuality()
	local quality=0;
	if self.data and self.data.quality then
		quality=self.data.quality;
	end
	return quality;
end

--图标缩放大小
function this:GetIconScale()
	local scale=1;
	if self.data and self.data.iconScale then
		scale=self.data.iconScale 
	end
    return scale;
end

--返回读取图标的工具类对象
function this:GetIconLoader()
	local iconLoader=ResUtil.IconGoods
	if self.data and self.data.iconLoader then
		iconLoader=self.data.iconLoader;
	end
    return iconLoader
end

function this:GetLv()
	local lv=0;
	if self.data and self.data.lv then
		lv=self.data.lv;
	end
	return lv;
end

function this:GetCount()
	local count=0;
	if self.data and self.data.count then
		count=self.data.count;
	end
	return count;
end

function this:GetDesc()
	local desc="";
	if self.data and self.data.desc then
		desc=self.data.desc;
	end
	return desc;
end

function this:GetStars()
	local stars=0;
	if self.data and self.data.stars then
		stars=self.data.stars;
	end
	return stars;
end

function this:IsNew()
	local isNew=false;
	if self.data and self.data.isNew then
		isNew=self.data.isNew;
	end
	return isNew;
end

function this:IsLock()
	local isLock=false;
	if self.data and self.data.isLock then
		isLock=self.data.isLock;
	end
	return isLock;
end

function this:GetClassType()
	return self.data and self.data.type or RandRewardType.ITEM;
end

function this:GetEquipped()
    return false;
end

return this;