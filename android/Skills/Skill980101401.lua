-- 暴虐气象被动4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980101401 = oo.class(SkillBase)
function Skill980101401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill980101401:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980101401
	local targets = SkillFilter:Group(self, caster, target, 4,4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[980101401], caster, target, data, 980101401)
	end
end
-- 攻击结束
function Skill980101401:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8235
	if SkillJudger:IsCasterMech(self, caster, self.card, true,4) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9731
	if SkillJudger:IsTypeOf(self, caster, target, true,4) then
	else
		return
	end
	-- 980101402
	self:AddBuff(SkillEffect[980101402], caster, caster, data, 980101402)
end
