-- 轰炸攻击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305000501 = oo.class(SkillBase)
function Skill305000501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305000501:DoSkill(caster, target, data)
	-- 11003
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
end
-- 行动结束
function Skill305000501:OnActionOver(caster, target, data)
	-- 305000501
	self:AddBuff(SkillEffect[305000501], caster, target, data, 305000501)
	-- 305000610
	self:ChangeSkill(SkillEffect[305000610], caster, target, data, 3,305000301)
	-- 305000510
	self:DelBufferForce(SkillEffect[305000510], caster, self.card, data, 305000321)
	-- 305000510
	self:DelBufferForce(SkillEffect[305000510], caster, self.card, data, 305000321)
end
