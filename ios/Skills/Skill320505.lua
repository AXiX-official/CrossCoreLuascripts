-- 波幅递进
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill320505 = oo.class(SkillBase)
function Skill320505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击开始
function Skill320505:OnAttackBegin(caster, target, data)
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
	-- 320505
	self:AddBuff(SkillEffect[320505], caster, target, data, 320505)
end
