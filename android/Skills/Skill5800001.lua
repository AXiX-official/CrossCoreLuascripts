-- 世界boss词条buff1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5800001 = oo.class(SkillBase)
function Skill5800001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill5800001:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 333306
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333306], caster, target, data, "LimitDamage1003",1)
	end
	-- 333316
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333316], caster, target, data, "LimitDamage1001",1)
	end
	-- 333326
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333326], caster, target, data, "LimitDamage1002",1)
	end
	-- 333336
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddValue(SkillEffect[333336], caster, target, data, "LimitDamage1051",1)
	end
end
-- 伤害前
function Skill5800001:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8427
	local count27 = SkillApi:BuffCount(self, caster, target,2,3,1001)
	-- 5800001
	self:AddTempAttr(SkillEffect[5800001], caster, target, data, "bedamage",0.2*coun27)
end
-- 攻击结束
function Skill5800001:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8427
	local count27 = SkillApi:BuffCount(self, caster, target,2,3,1001)
	-- 8110
	if SkillJudger:Greater(self, caster, self.card, true,count27,0) then
	else
		return
	end
	-- 5800002
	if self:Rand(5000) then
		self:AlterRandBufferByID(SkillEffect[5800002], caster, target, data, 1003,1)
	end
end
