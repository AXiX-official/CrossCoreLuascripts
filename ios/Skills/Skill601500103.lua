-- 缇尔锋1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill601500103 = oo.class(SkillBase)
function Skill601500103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill601500103:DoSkill(caster, target, data)
	-- 11003
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
end
-- 攻击结束
function Skill601500103:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 601500102
	self:HitAddBuff(SkillEffect[601500102], caster, target, data, 2500,3004)
end
