-- 苦痛程式
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500200303 = oo.class(SkillBase)
function Skill500200303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500200303:DoSkill(caster, target, data)
	-- 11003
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
