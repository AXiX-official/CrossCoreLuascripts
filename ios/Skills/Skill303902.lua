-- 幸运修复
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill303902 = oo.class(SkillBase)
function Skill303902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill303902:OnCure(caster, target, data)
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 303902
	if self:Rand(4000) then
		self:AddBuff(SkillEffect[303902], caster, target, data, 4604,1)
	end
end
