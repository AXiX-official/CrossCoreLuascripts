-- 荧天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill327705 = oo.class(SkillBase)
function Skill327705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill327705:OnRoundBegin(caster, target, data)
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
	-- 327705
	if self:Rand(5000) then
		self:DelBufferGroup(SkillEffect[327705], caster, self.card, data, 1,1)
		-- 327715
		self:AddBuff(SkillEffect[327715], caster, self.card, data, 327705)
	end
end
