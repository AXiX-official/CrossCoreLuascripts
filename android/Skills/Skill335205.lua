-- 赤夕4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill335205 = oo.class(SkillBase)
function Skill335205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill335205:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 335205
	self:AddNp(SkillEffect[335205], caster, self.card, data, 10)
end
