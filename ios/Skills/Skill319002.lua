-- 透甲重击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill319002 = oo.class(SkillBase)
function Skill319002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill319002:OnBefourHurt(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8126
	if SkillJudger:IsTargetCareer(self, caster, target, true,1) then
	else
		return
	end
	-- 319002
	self:AddTempAttr(SkillEffect[319002], caster, caster, data, "damage",0.12)
end
