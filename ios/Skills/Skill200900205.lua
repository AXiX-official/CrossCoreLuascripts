-- 治愈和弦
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200900205 = oo.class(SkillBase)
function Skill200900205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200900205:DoSkill(caster, target, data)
	-- 200900205
	self.order = self.order + 1
	self:Cure(SkillEffect[200900205], caster, target, data, 1,0.30)
end
