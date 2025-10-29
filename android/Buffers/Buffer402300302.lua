-- 夺取攻击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer402300302 = oo.class(BuffBase)
function Buffer402300302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer402300302:OnCreate(caster, target)
	-- 8767
	local c767 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"speed")
	-- 8420
	local c20 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"speed")
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 402300302
	self:AddAttr(BufferEffect[402300302], self.caster, self.creater, nil, "attack",math.min(math.abs((c767-c20)*c15*0.004),0.4*c15))
	-- 8767
	local c767 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"speed")
	-- 8420
	local c20 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"speed")
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 402300312
	self:AddAttr(BufferEffect[402300312], self.caster, self.card, nil, "attack",-math.min(math.abs((c767-c20)*c15*0.004),0.4*c15))
end
-- 行动结束2
function Buffer402300302:OnActionOver2(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 402300314
	self:DelBufferTypeForce(BufferEffect[402300314], self.caster, self.card, nil, 402300301)
end
