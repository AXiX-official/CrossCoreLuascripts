-- 催化效能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill314402 = oo.class(SkillBase)
function Skill314402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 驱散buff时
function Skill314402:OnDelBuff(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 314402
	self:AddBuff(SkillEffect[314402], caster, self.card, data, 3302)
end
