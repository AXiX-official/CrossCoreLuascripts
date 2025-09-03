-- 利兹2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304500204 = oo.class(SkillBase)
function Skill304500204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill304500204:DoSkill(caster, target, data)
	-- 200900204
	self.order = self.order + 1
	self:Cure(SkillEffect[200900204], caster, target, data, 1,0.28)
end
