-- 对耐久大于70%的单位攻击伤害加深10%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010030 = oo.class(SkillBase)
function Skill1100010030:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100010030:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8092
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.7) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100010030
	self:AddTempAttr(SkillEffect[1100010030], caster, self.card, data, "damage",0.1)
end