-- 微观
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4200805 = oo.class(SkillBase)
function Skill4200805:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill4200805:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4200804
	if self:Rand(3500) then
		self:AddProgress(SkillEffect[4200804], caster, self.card, data, 300)
		-- 4200806
		self:ShowTips(SkillEffect[4200806], caster, self.card, data, 2,"微观",true,4200806)
	end
end
-- 行动结束
function Skill4200805:OnActionOver(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 4200805
	if self:Rand(1000) then
		self:AddProgress(SkillEffect[4200805], caster, caster, data, 300)
		-- 4200806
		self:ShowTips(SkillEffect[4200806], caster, self.card, data, 2,"微观",true,4200806)
	end
end
