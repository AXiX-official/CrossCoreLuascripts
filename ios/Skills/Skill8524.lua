-- 天赋效果24
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8524 = oo.class(SkillBase)
function Skill8524:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8524:OnAttackOver(caster, target, data)
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8104
	if SkillJudger:Greater(self, caster, self.card, true,count18,99) then
	else
		return
	end
	-- 93002
	if SkillJudger:CheckCD(self, caster, target, false) then
	else
		return
	end
	-- 8524
	self:CallSkill(SkillEffect[8524], caster, self.card, data, 800900301)
end
