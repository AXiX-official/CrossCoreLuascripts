-- 测试rougelike词条迅捷8
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill25502 = oo.class(SkillBase)
function Skill25502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill25502:OnBorn(caster, target, data)
	-- 1000010080
	self:AddBuff(SkillEffect[1000010080], caster, self.card, data, 1000010080)
end
