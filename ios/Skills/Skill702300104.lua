-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill702300104 = oo.class(SkillBase)
function Skill702300104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill702300104:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
end
