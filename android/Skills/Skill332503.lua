-- ccc2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill332503 = oo.class(SkillBase)
function Skill332503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill332503:OnAttackOver(caster, target, data)
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
	-- 8260
	if SkillJudger:IsTypeOf(self, caster, target, true,5) then
	else
		return
	end
	-- 332513
	self:AddBuff(SkillEffect[332513], caster, target, data, 332513)
end
