-- 双子宫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983610401 = oo.class(SkillBase)
function Skill983610401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill983610401:DoSkill(caster, target, data)
	-- 12003
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12003], caster, target, data, 0.333,3)
end
-- 攻击结束
function Skill983610401:OnAttackOver(caster, target, data)
	-- 983610204
	self:DelBufferForce(SkillEffect[983610204], caster, self.card, data, 983610202,1)
	-- 983610205
	self:ChangeSkill(SkillEffect[983610205], caster, self.card, data, 2,983610201)
end
