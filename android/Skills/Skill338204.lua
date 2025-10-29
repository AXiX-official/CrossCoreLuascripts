-- 夏炙4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338204 = oo.class(SkillBase)
function Skill338204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill338204:OnRoundBegin(caster, target, data)
	-- 8580
	local count101 = SkillApi:BuffCount(self, caster, target,1,2,2)
	-- 8954
	if SkillJudger:Greater(self, caster, self.card, true,count101,0) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 338204
	self:AddBuffCount(SkillEffect[338204], caster, self.card, data, 338204,math.min(count101,2),999)
	-- 338214
	self:DelBuffQuality(SkillEffect[338214], caster, self.card, data, 2,2)
end
