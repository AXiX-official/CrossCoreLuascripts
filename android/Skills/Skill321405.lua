-- 应急反应
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill321405 = oo.class(SkillBase)
function Skill321405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill321405:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 321405
	self:AddBuff(SkillEffect[321405], caster, self.card, data, 321405)
end
