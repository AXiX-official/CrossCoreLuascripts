-- 碎星阵营角色，怪物控制被控制时，攻击后使怪物被劣化，持续2回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070040 = oo.class(SkillBase)
function Skill1100070040:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100070040:OnAttackOver(caster, target, data)
	-- 8903
	if SkillJudger:HasBuff(self, caster, target, true,2,1,1) then
	else
		return
	end
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
	-- 1100070040
	self:HitAddBuff(SkillEffect[1100070040], caster, target, data, 10000,1001,2)
end
