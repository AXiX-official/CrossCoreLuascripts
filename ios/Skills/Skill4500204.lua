-- 恶意代码
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4500204 = oo.class(SkillBase)
function Skill4500204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4500204:OnAttackOver(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 4500204
	self:HitAddBuff(SkillEffect[4500204], caster, target, data, 3500,500200301)
end
