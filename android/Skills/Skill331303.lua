-- 荷鲁斯2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331303 = oo.class(SkillBase)
function Skill331303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill331303:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 331303
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[331303], caster, target, data, 331303)
	end
end
