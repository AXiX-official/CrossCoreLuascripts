-- 冥能修复
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill907000201 = oo.class(SkillBase)
function Skill907000201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill907000201:DoSkill(caster, target, data)
	-- 907000201
	self.order = self.order + 1
	self:Cure(SkillEffect[907000201], caster, target, data, 1,0.15)
end
