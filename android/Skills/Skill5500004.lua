-- 溯源探查第二期ex新增技能4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5500004 = oo.class(SkillBase)
function Skill5500004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill5500004:OnRoundOver(caster, target, data)
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 910600904
	if SkillJudger:Equal(self, caster, target, true,(playerturn%10),0) then
	else
		return
	end
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 907800610
	if SkillJudger:Greater(self, caster, self.card, true,playerturn,0) then
	else
		return
	end
	-- 5500004
	self:AddBuff(SkillEffect[5500004], caster, self.card, data, 907800606)
end
