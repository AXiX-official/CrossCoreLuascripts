-- 测试rougelike词条迅捷5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill25402 = oo.class(SkillBase)
function Skill25402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill25402:OnBorn(caster, target, data)
	-- 1000010050
	self:AddBuff(SkillEffect[1000010050], caster, self.card, data, 1000010050)
end
