-- 琶音天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill329602 = oo.class(SkillBase)
function Skill329602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill329602:OnActionOver(caster, target, data)
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
	-- 329602
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddProgress(SkillEffect[329602], caster, target, data, 40)
	end
end
