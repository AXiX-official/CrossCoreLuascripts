-- 冷冻流星
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911600101 = oo.class(SkillBase)
function Skill911600101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill911600101:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill911600101:OnAttackOver(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 911600101
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.5) then
		-- 911600103
		self:HitAddBuff(SkillEffect[911600103], caster, target, data, 10000,3004,1)
	else
		-- 911600102
		self:HitAddBuff(SkillEffect[911600102], caster, target, data, 2500,3004,1)
	end
end
