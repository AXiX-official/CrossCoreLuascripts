-- 熔铄4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill335404 = oo.class(SkillBase)
function Skill335404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill335404:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8246
	if SkillJudger:IsTargetMech(self, caster, target, true,10) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 335404
	self:OwnerAddBuff(SkillEffect[335404], caster, target, data, 1095)
end
