-- 克拉伦特2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331903 = oo.class(SkillBase)
function Skill331903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill331903:OnBefourHurt(caster, target, data)
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
	-- 331903
	self:AddTempAttrPercent(SkillEffect[331903], caster, target, data, "defense",-0.2)
end
