-- 测试rougelike词条迅捷18
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill25803 = oo.class(SkillBase)
function Skill25803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill25803:OnBorn(caster, target, data)
	-- 1000010180
	self:AddBuff(SkillEffect[1000010180], caster, self.card, data, 1000010180)
end
