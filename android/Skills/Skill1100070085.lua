-- 溯源探查ex技能5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070085 = oo.class(SkillBase)
function Skill1100070085:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100070085:OnAttackOver(caster, target, data)
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
	-- 1100070085
	self:HitAddBuff(SkillEffect[1100070085], caster, target, data, 5000,1001)
end
-- 行动结束
function Skill1100070085:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100070086
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[1100070086], caster, caster, data, 1001)
	end
end
