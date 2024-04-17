-- 抗压I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24701 = oo.class(SkillBase)
function Skill24701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill24701:OnActionOver(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 24701
	self:AddBuff(SkillEffect[24701], caster, self.card, data, 24701)
end
