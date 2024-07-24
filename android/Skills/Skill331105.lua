-- 阿努比斯2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331105 = oo.class(SkillBase)
function Skill331105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill331105:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 331105
	self:AddTempAttr(SkillEffect[331105], caster, self.card, data, "damage",0.20)
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8467
	local count67 = SkillApi:GetAttr(self, caster, target,2,"hp")
	-- 8189
	if SkillJudger:Greater(self, caster, target, true,count20,count67) then
	else
		return
	end
	-- 331115
	self:AddTempAttr(SkillEffect[331115], caster, self.card, data, "damage",0.20)
end
