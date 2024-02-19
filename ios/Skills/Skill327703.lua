-- 荧天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill327703 = oo.class(SkillBase)
function Skill327703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill327703:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8496
	local count96 = SkillApi:BuffCount(self, caster, target,3,1,1)
	-- 8193
	if SkillJudger:Greater(self, caster, target, true,count96,0) then
	else
		return
	end
	-- 327703
	if self:Rand(4000) then
		self:DelBufferGroup(SkillEffect[327703], caster, self.card, data, 1,1)
		-- 327713
		self:AddBuff(SkillEffect[327713], caster, self.card, data, 327703)
	end
end
