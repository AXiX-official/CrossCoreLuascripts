-- 皮奥维利奇
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202400302 = oo.class(SkillBase)
function Skill202400302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202400302:DoSkill(caster, target, data)
	-- 202400302
	self.order = self.order + 1
	self:AddBuff(SkillEffect[202400302], caster, target, data, 202400302)
	-- 202400306
	self.order = self.order + 1
	self:Cure(SkillEffect[202400306], caster, target, data, 2,0.1)
	-- 202400309
	self.order = self.order + 1
	self:AddProgress(SkillEffect[202400309], caster, target, data, 1010)
end
