-- 扩散爆炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill402200402 = oo.class(SkillBase)
function Skill402200402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill402200402:DoSkill(caster, target, data)
	-- 4402212
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4402212], caster, target, data, 1033)
end
