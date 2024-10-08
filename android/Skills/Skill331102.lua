-- 阿努比斯2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331102 = oo.class(SkillBase)
function Skill331102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill331102:OnBefourHurt(caster, target, data)
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
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 331102
	self:AddTempAttr(SkillEffect[331102], caster, self.card, data, "damage",0.08)
	-- 8092
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.7) then
	else
		return
	end
	-- 331112
	self:AddTempAttr(SkillEffect[331112], caster, self.card, data, "damage",0.08)
end
