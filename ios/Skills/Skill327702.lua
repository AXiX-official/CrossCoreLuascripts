-- 荧天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill327702 = oo.class(SkillBase)
function Skill327702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill327702:OnRoundBegin(caster, target, data)
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
	-- 327702
	if self:Rand(3500) then
		self:DelBufferGroup(SkillEffect[327702], caster, self.card, data, 1,1)
		-- 327712
		self:AddBuff(SkillEffect[327712], caster, self.card, data, 327702)
	end
end
