-- 冰霜巨人被动2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill907700501 = oo.class(SkillBase)
function Skill907700501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill907700501:OnBefourHurt(caster, target, data)
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
	-- 907700501
	if self:Rand(5000) then
		self:AddTempAttrPercent(SkillEffect[907700501], caster, caster, data, "attack",-0.4)
	end
end
