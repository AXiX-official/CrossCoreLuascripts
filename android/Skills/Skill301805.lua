-- 感知充能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301805 = oo.class(SkillBase)
function Skill301805:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill301805:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 301805
	if self:Rand(6000) then
		self:AddNp(SkillEffect[301805], caster, self.card, data, 10)
	end
end
