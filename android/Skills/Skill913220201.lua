-- 刃 2技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913220201 = oo.class(SkillBase)
function Skill913220201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill913220201:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill913220201:OnAttackOver(caster, target, data)
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
	-- 913220201
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[913220201], caster, target, data, 1003)
	end
end
