-- 限制II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010321 = oo.class(SkillBase)
function Skill1100010321:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill1100010321:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8138
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.8) then
	else
		return
	end
	-- 1100010321
	self:AddBuff(SkillEffect[1100010321], caster, self.card, data, 1100010321)
end
