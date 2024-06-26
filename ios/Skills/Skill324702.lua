-- 特技强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill324702 = oo.class(SkillBase)
function Skill324702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill324702:OnBefourHurt(caster, target, data)
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
	-- 324702
	self:AddTempAttr(SkillEffect[324702], caster, self.card, data, "damage",0.08)
end
-- 攻击结束
function Skill324702:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 324711
	self:ChangeSkill(SkillEffect[324711], caster, self.card, data, 2,301500501)
end
