-- 溯源探查ex技能12
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070092 = oo.class(SkillBase)
function Skill1100070092:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100070092:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100010132
	self:OwnerAddBuff(SkillEffect[1100010132], caster, self.card, data, 1100010132)
end
