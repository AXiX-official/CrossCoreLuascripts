-- 岁稔2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill335504 = oo.class(SkillBase)
function Skill335504:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill335504:OnActionOver(caster, target, data)
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 335504
	self:Cure(SkillEffect[335504], caster, self.card, data, 2,0.08)
end
