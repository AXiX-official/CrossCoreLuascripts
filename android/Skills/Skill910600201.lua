-- 肩部射线
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill910600201 = oo.class(SkillBase)
function Skill910600201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill910600201:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 攻击结束
function Skill910600201:OnAttackOver(caster, target, data)
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
	-- 910600201
	self:HitAddBuff(SkillEffect[910600201], caster, target, data, 10000,5104,2)
end
