-- 刺蝽3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill503001305 = oo.class(SkillBase)
function Skill503001305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill503001305:DoSkill(caster, target, data)
	-- 11005
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11005], caster, target, data, 0.2,5)
end
-- 攻击结束
function Skill503001305:OnAttackOver(caster, target, data)
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
	-- 503001301
	if self:Rand(5000) then
		self:ClosingBuffByID(SkillEffect[503001301], caster, target, data, 1,1003)
	end
end
