-- 溯源探查ex技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070082 = oo.class(SkillBase)
function Skill1100070082:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100070082:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100070082
	self:AddBuff(SkillEffect[1100070082], caster, self.card, data, 1100070082)
end
