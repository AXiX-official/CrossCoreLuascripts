-- 信风2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill400200203 = oo.class(SkillBase)
function Skill400200203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill400200203:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
