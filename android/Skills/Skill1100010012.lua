-- 普攻忽略目标10%的防御
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010012 = oo.class(SkillBase)
function Skill1100010012:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100010012:OnBefourHurt(caster, target, data)
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
	-- 1100010012
	self:AddTempAttrPercent(SkillEffect[1100010012], caster, target, data, "defense",-0.10)
end