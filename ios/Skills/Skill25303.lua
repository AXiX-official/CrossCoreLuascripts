-- 测试rougelike词条迅捷3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill25303 = oo.class(SkillBase)
function Skill25303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill25303:OnBorn(caster, target, data)
	-- 1000010030
	self:AddBuff(SkillEffect[1000010030], caster, self.card, data, 1000010030)
end
