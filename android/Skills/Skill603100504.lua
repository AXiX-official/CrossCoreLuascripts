-- 提泽纳2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603100504 = oo.class(SkillBase)
function Skill603100504:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603100504:DoSkill(caster, target, data)
	-- 603100504
	self.order = self.order + 1
	self:Cure(SkillEffect[603100504], caster, target, data, 1,0.18)
end
