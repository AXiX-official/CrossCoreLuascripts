-- 拉被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4703604 = oo.class(SkillBase)
function Skill4703604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4703604:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703604
	if self:Rand(6000) then
		self:AddNp(SkillEffect[4703604], caster, self.card, data, 20)
		-- 4703608
		self:CallSkill(SkillEffect[4703608], caster, self.card, data, 703600403)
	end
end
-- 入场时
function Skill4703604:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703624
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4703624], caster, target, data, 4703624)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill4703604:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703624
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4703624], caster, target, data, 4703624)
	end
end
-- 死亡时
function Skill4703604:OnDeath(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703626
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[4703626], caster, target, data, 4703621)
	end
end
