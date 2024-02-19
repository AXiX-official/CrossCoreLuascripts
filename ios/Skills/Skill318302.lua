-- 受击转化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill318302 = oo.class(SkillBase)
function Skill318302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill318302:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 318311
	self:AddBuff(SkillEffect[318311], caster, self.card, data, 1021)
end
-- 攻击结束
function Skill318302:OnAttackOver(caster, target, data)
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
	-- 318302
	self:AddBuff(SkillEffect[318302], caster, self.card, data, 318302)
end
