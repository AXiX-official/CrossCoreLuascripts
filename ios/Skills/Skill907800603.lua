-- 稽查者加强被动3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill907800603 = oo.class(SkillBase)
function Skill907800603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill907800603:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 907800608
	if SkillJudger:Equal(self, caster, target, true,(playerturn%3),0) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 907800606
	self:AddBuff(SkillEffect[907800606], caster, self.card, data, 2105)
end
