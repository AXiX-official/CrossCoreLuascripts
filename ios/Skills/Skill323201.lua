-- 行动提前
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill323201 = oo.class(SkillBase)
function Skill323201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill323201:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 323201
	self:AddProgress(SkillEffect[323201], caster, target, data, 100)
end
