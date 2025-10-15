-- 分解者技能5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914100501 = oo.class(SkillBase)
function Skill914100501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914100501:DoSkill(caster, target, data)
	-- 11006
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11006], caster, target, data, 0.167,6)
end
