-- 极速抵御
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill327604 = oo.class(SkillBase)
function Skill327604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill327604:OnActionOver(caster, target, data)
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
	-- 327604
	self:AddBuff(SkillEffect[327604], caster, self.card, data, 327604)
end
