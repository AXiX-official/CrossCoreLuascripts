-- 裂空2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334302 = oo.class(SkillBase)
function Skill334302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill334302:OnBefourHurt(caster, target, data)
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
	-- 334302
	self:AddTempAttr(SkillEffect[334302], caster, self.card, data, "damage",0.15)
end
-- 攻击结束
function Skill334302:OnAttackOver(caster, target, data)
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
	-- 334306
	self:DelBufferGroup(SkillEffect[334306], caster, target, data, 2,2)
end
