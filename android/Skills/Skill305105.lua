-- 天赋效果305105
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305105 = oo.class(SkillBase)
function Skill305105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill305105:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305105
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[305105], caster, self.card, data, 4004,1)
	end
end
