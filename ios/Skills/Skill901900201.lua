-- 高效维复
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill901900201 = oo.class(SkillBase)
function Skill901900201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill901900201:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 901900201
	self.order = self.order + 1
	self:Cure(SkillEffect[901900201], caster, target, data, 1,0.2)
end
