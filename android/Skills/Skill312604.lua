-- 天赋效果312604
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill312604 = oo.class(SkillBase)
function Skill312604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill312604:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 312604
	self:FlyAdjust(SkillEffect[312604], caster, self.card, data, 1.20,10000)
end
