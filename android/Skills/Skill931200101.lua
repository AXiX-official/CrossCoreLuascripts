-- 爆裂攻击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill931200101 = oo.class(SkillBase)
function Skill931200101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill931200101:DoSkill(caster, target, data)
	-- 11003
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
end
