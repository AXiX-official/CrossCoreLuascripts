-- 灵风交响
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200800304 = oo.class(SkillBase)
function Skill200800304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200800304:DoSkill(caster, target, data)
	-- 200800304
	self.order = self.order + 1
	self:Cure(SkillEffect[200800304], caster, target, data, 1,0.19)
	-- 200800313
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200800313], caster, target, data, 200800313,2)
end
