-- 皮奥维利奇（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill202401305 = oo.class(SkillBase)
function Skill202401305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill202401305:DoSkill(caster, target, data)
	-- 202400305
	self.order = self.order + 1
	self:AddBuff(SkillEffect[202400305], caster, target, data, 202400303)
	-- 202400308
	self.order = self.order + 1
	self:Cure(SkillEffect[202400308], caster, target, data, 2,0.2)
	-- 202400309
	self.order = self.order + 1
	self:AddProgress(SkillEffect[202400309], caster, target, data, 1010)
	-- 202401301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[202401301], caster, target, data, 402901301)
end
