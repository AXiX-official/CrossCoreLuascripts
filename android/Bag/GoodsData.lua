-- 物品数据
local this = oo.class(GridDataBase)

--设置物品信息
function this:Init(goodsData)
	if goodsData then
		self.data = goodsData;
		self:InitCfg(self.data.id);
	end
end

-- --设置物品信息
-- function this:SetData(goodsData)
-- 	self.data = goodsData;
-- 	self:InitCfg(self.data.id);
-- end
--初始化配置
function this:InitCfg(cfgId)
	if(cfgId == nil) then
		LogError("初始化物品配置失败！无效配置id");		
	end
	
	if(self.cfg == nil) then		
		self.cfg = Cfgs.ItemInfo:GetByID(cfgId);
		if(self.cfg == nil) then		
			LogError("找不到物品配置！id = " .. cfgId);	
		end
	end
end

--获取id
function this:GetID()
	return self.data.id or - 1;
end
--获取数据
function this:GetData()
	return self.data;
end
--获取配置
function this:GetCfg()
	return self.cfg;
end

function this:IsNew()
	return BagMgr:IsNew(self:GetID())
end

--物品类型
function this:GetItemType()
	return self:GetType()
end

function this:GetTag()
	return self.data and self.data.tag
end

function this:GetCfgTag()
	return self.cfg and self.cfg.tag or nil;
end

function this:GetClassType()
	return "GoodsData"
end

--获取类型
function this:GetType()
	return self.cfg and self.cfg.type or 0;
end

function this:GetCfgID()
	return self.cfg and self.cfg.id or - 1;
end

--获取类型
function this:GetName()
	return self.cfg and self.cfg.name .. "";
end

--获取数量
function this:GetCount()
	return self.data and self.data.num or 0;
end
--获取等级
function this:GetLv()
	return 0;
end

--物品描述
function this:GetDesc()
	return self.cfg and self.cfg.describe or "";
end

--简短描述
function this:GetDesc2()
	return self.cfg and self.cfg.describeBase or "";
end

--获取品质
function this:GetQuality()
	return self.cfg and self.cfg.quality or 1;
end
--获取图标
function this:GetIcon()
	if self:GetType()==ITEM_TYPE.CARD_CORE_ELEM then
		return self.cfg and string.format("%s_%s",self.cfg.icon,self:GetQuality());
	else
		return self.cfg and self.cfg.icon;
	end
end

--角色圆形图标
function this:GetIconRole()
	if(self:GetType()==ITEM_TYPE.CARD) then 
		local roleCfg = Cfgs.CardData:GetByID(self:GetCardID())
		local cfgModel = (roleCfg and roleCfg.model) and Cfgs.character:GetByID(roleCfg.model) or nil 
		return cfgModel and cfgModel.icon  or nil 
	end 
	return nil
end

--角色圆形图标2
function this:GetIconRole2()
	if(self:GetType()==ITEM_TYPE.CARD) then 
		local roleCfg = Cfgs.CardData:GetByID(self:GetCardID())
		local cfgModel = (roleCfg and roleCfg.model) and Cfgs.character:GetByID(roleCfg.model) or nil 
		return cfgModel and cfgModel.card_icon  or nil 
	end 
	return nil
end

function this:GetIconLoader()
	local loader=ResUtil.IconGoods;
	if self.cfg and self:GetType()==ITEM_TYPE.CARD then
		loader=ResUtil.RoleCard;
	elseif self.cfg and (self:GetType()==ITEM_TYPE.FORNITURE or self:GetType()==ITEM_TYPE.THEME) then
		loader=ResUtil.Furniture;
	end
    return loader;
end

function this:GetIconScale()
	if self.cfg and self:GetType()==ITEM_TYPE.EQUIP then
		return 1;
	else
		return 1;
	end
end

--卡牌id
function this:GetCardID()
	return self.cfg and self.cfg.card_id or nil
end

-- --是否是卡牌升级物品
-- function this:IsMaterialExp()
-- 	if(self:GetType() == ITEM_TYPE.PROP) then
-- 		if(self.cfg.dy_value1 == ITEM_TYPE.ExpMaterial and self.cfg.dy_tb) then 
-- 			return true 
-- 		end 
-- 	end 
-- 	return false 
-- end


--升级时提供的经验
function this:GetMaterialExp()
	if(self.cfg.type == ITEM_TYPE.PROP and self.cfg.dy_value1 == ITEM_TYPE.ExpMaterial) then
		local ret = GLogicCheck:GetItemExp(self:GetID())
		return ret[1]
	elseif self:GetType() == 7 then
		--装备素材
		return self.cfg.dy_value1 or 0;
	end
	return 0
end

function this:GetUpExp()
	if(self.cfg.type == ITEM_TYPE.PROP and self.cfg.dy_value1 == ITEM_TYPE.ExpMaterial) then
		local ret = GLogicCheck:GetItemExp(self:GetID())
		return ret[1]
	end
	return 0
end

--使用该物品作为素材进行升级时需要消耗的金币
function this:GetMaterialGold()
	if self:GetType() == 7 then
		return self.cfg.dy_value2 or 0;
	end
	return 0;
end

-- --是否是卡牌强化物品
-- function this:IsDecomposeExp()
-- 	if(self:GetType() == ITEM_TYPE.PROP) then
-- 		if(self.cfg.dy_value1 == ITEM_TYPE.ExpMaterial and self.cfg.dy_tb) then 
-- 			return elf.cfg.dy_tb[2]>0  
-- 		end 
-- 	end 
-- 	return false 
-- end
--强化时提供的经验
function this:GetDecomposeExp()
	if(self.cfg.type == ITEM_TYPE.PROP and self.cfg.dy_value1 == ITEM_TYPE.ExpMaterial) then
		local ret = GLogicCheck:GetItemExp(self:GetID())
		return ret[2]
	end
	return 0
end

--返回dy_tb掉落的物品信息
function this:GetDropList()
	local list=nil;
	if self.cfg and self.cfg.dy_tb then
		list={};
		for k,v in ipairs(self.cfg.dy_tb) do
			local type=v[3];
			local data=nil;
			if type==RandRewardType.ITEM then
				data= GoodsData();
				data:InitCfg(v[1]);
			elseif type==RandRewardType.CARD then
				data= CharacterCardsData();
				data:InitCfg(v[1]);
			elseif type==RandRewardType.EQUIP then
				data= EquipData();
				data:InitCfg(v[1]);
			end
			table.insert(list, {data=data,cid=v[1],num = v[2],type=type})
		end
	end
	return list;
end

--返回头像和头像框的剩余天数描述
function this:GetIconDayTips()
	local tips=nil;
	if self:GetItemType()==ITEM_TYPE.PROP and (self:GetDyVal1()==PROP_TYPE.IconFrame or self:GetDyVal1()==PROP_TYPE.Icon) then
		local dyArr=self:GetDyArr();
		if dyArr and dyArr[2]~=0 then
			local result=TimeUtil:GetTimeTab(dyArr[2]);
			if result[1]>0 then
				tips=LanguageMgr:GetByID(46006,result[1]);
			elseif result[2]>0 then
				tips=LanguageMgr:GetByID(46007,result[2]);
			elseif result[3]>0 then
				tips=LanguageMgr:GetByID(46008,result[3]);
			end
		-- elseif dyArr and dyArr[2]==0 then
		-- 	tips=LanguageMgr:GetByID(46009);
		end
	end
	return tips;
end

--动态值1
function this:GetDyVal1()
	return self.cfg and self.cfg.dy_value1 or nil;
end

--动态值2
function this:GetDyVal2()
	return self.cfg and self.cfg.dy_value2 or nil;
end

function this:GetDyArr()
	return self.cfg and self.cfg.dy_arr or nil;
end

--返回会员卡类型
function this:GetMemberCardType()
	local arr=self:GetDyArr();
	if arr and arr[2] and self:GetDyVal1()==3 then
		return arr[2];
	end
end

--返回关卡掉落信息 
function this:GetGetWayInfo()
	local infos=nil;
	if self.cfg and self.cfg.getInfo then
		infos={};
		for k,v in ipairs(self.cfg.getInfo) do
			local jumpId=v[1];
			local state,lockStr=JumpMgr:GetJumpState(jumpId);
			local outTips=nil;
			if v[2] then
				local cfg=Cfgs.CfgOutTypeEnum:GetByID(v[2]);
				outTips=cfg.sName;
			end
			table.insert(infos,{jumpId=jumpId,state=state,lockStr=lockStr,outTips=outTips});
		end
	end
	return infos;
end

--返回基地生产掉落信息
function this:GetCombineGetInfo()
	local infos=nil;
	if self.cfg and self.cfg.combineGet then
		infos={};
		for k,v in ipairs(self.cfg.combineGet) do
			local jumpId=v;
			local state,lockStr=JumpMgr:GetJumpState(jumpId);
			table.insert(infos,{jumpId=jumpId,lockStr=lockStr,state=state});
		end
	end
	return infos;
end

--返回其他获取方式信息 (跳转入口)
function this:GetJOtherGetInfo()
	local infos=nil;
	if self.cfg and self.cfg.j_otherGet then
		infos={};
		for k,v in ipairs(self.cfg.j_otherGet) do
			local jumpId=v;
			local state,lockStr=JumpMgr:GetJumpState(jumpId);
			table.insert(infos,{jumpId=jumpId,lockStr=lockStr,state=state});
		end
	end
	return infos;
end

--返回其他获取方式信息（文字描述部分，不提供跳转）
function this:GetTOtherGetInfo()
	local infos=nil;
	if self.cfg and self.cfg.t_otherGet then
		-- infos=self.cfg.t_otherGet;
		infos={};
		for k,v in ipairs(self.cfg.t_otherGet) do
			local text=LanguageMgr:GetByID(v);
			if text~=nil then
				table.insert(infos,text);
			end
		end
	end
	return infos;
end

function this:GetMoneyJumpID()
	local id=nil;
	if self.cfg and self.cfg.j_moneyGet then
		id=self.cfg.j_moneyGet
	end
	return id;
end

--返回失效日期
function this:GetExpiry()
	if self.cfg and self.cfg.sExpiry then
		return TimeUtil:GetTimeStampBySplit(self.cfg.sExpiry);
	end
	return nil;
end

function this:GetExpiryTips()
	local time=self:GetExpiry();
	if time then
		local count=TimeUtil:GetDiffHMS(time,TimeUtil.GetTime());
		if count.day<0 then
			return LanguageMgr:GetByID(24027);
		end
		return count.day>0 and LanguageMgr:GetByID(24024,count.day) or LanguageMgr:GetByID(24024,1);
	end
	return nil;
end

--第一个入手时间
function this:GetAcquireTime()
	return self.data.time or 0 
end

--过期时间（头像框）
function this:GetHeadFrameExpiry()
	if(self.data.expiry==nil or self.data.expiry==0) then 
		return nil 
	end 
	return self.data.expiry
end

-- ----------------------------------------状态记录--------------------------------------
-- --是否被选择为素材
-- function this:GetIsSelect()
-- 	return(self.isSelect == nil) and false or self.isSelect
-- end

-- function this:SetIsSelect(b)
-- 	b = b == nil and false or b
-- 	self.isSelect = b
-- 	self.selectCount = self.isSelect and self.selectCount or 1
-- end

-- --选择的数量
-- function this:GetSelectCount()
-- 	self.selectCount = self.selectCount or 0
-- 	return self.selectCount
-- end

-- function this:SetSelectCount(_num)
-- 	_num = _num == nil and self:GetCount() or _num
-- 	self.selectCount = _num
-- end


return this; 