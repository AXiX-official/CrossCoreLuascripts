-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill710100210 = oo.class(SkillBase)
function Skill710100210:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill710100210:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
end
