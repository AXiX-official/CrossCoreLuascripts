-- 测试rougelike词条迅捷9
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill25503 = oo.class(SkillBase)
function Skill25503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill25503:OnBorn(caster, target, data)
	-- 1000010090
	self:AddBuff(SkillEffect[1000010090], caster, self.card, data, 1000010090)
end
