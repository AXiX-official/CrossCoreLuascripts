-- 紧急修复
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill931500101 = oo.class(SkillBase)
function Skill931500101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill931500101:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 901800201
	self.order = self.order + 1
	self:Cure(SkillEffect[901800201], caster, target, data, 1,0.4)
end
