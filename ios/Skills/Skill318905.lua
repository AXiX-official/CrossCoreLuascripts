-- 乘适行进
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill318905 = oo.class(SkillBase)
function Skill318905:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill318905:OnAfterHurt(caster, target, data)
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
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 318905
	self:AddProgress(SkillEffect[318905], caster, self.card, data, 100)
end
