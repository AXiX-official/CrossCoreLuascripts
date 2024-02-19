-- 命中伤害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill325103 = oo.class(SkillBase)
function Skill325103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill325103:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8620
	local count620 = SkillApi:GetAttr(self, caster, target,3,"hit")
	-- 325103
	self:AddTempAttr(SkillEffect[325103], caster, self.card, data, "damage",count620*0.3)
end
