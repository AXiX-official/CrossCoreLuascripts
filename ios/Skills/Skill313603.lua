-- 天赋效果313603
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill313603 = oo.class(SkillBase)
function Skill313603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill313603:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 313603
	if self:Rand(6000) then
		self:AddSp(SkillEffect[313603], caster, self.card, data, 20)
	end
end
