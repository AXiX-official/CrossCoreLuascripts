-- 先手
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4501904 = oo.class(SkillBase)
function Skill4501904:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4501904:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4501904
	self:AddProgress(SkillEffect[4501904], caster, self.card, data, 350)
end
