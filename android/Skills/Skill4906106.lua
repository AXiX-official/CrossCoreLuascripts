-- 狂暴无限血
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4906106 = oo.class(SkillBase)
function Skill4906106:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4906106:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4906109
	local turncount = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 4906110
	if SkillJudger:Equal(self, caster, target, true,turncount,20) then
	else
		return
	end
	-- 4906106
	self:AddUplimitBuff(SkillEffect[4906106], caster, self.card, data, 3,3,4906103,1,4906103)
end
