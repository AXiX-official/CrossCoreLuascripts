-- 疾风迅剑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill315404 = oo.class(SkillBase)
function Skill315404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 切换周目
function Skill315404:OnChangeStage(caster, target, data)
	-- 315404
	self:AddProgress(SkillEffect[315404], caster, self.card, data, 320)
end
