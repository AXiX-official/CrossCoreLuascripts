-- 感知充能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301803 = oo.class(SkillBase)
function Skill301803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill301803:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 301803
	if self:Rand(4000) then
		self:AddNp(SkillEffect[301803], caster, self.card, data, 10)
	end
end
