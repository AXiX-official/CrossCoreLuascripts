-- 拉4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331802 = oo.class(SkillBase)
function Skill331802:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill331802:OnBefourHurt(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 331802
	self:AddTempAttr(SkillEffect[331802], caster, self.card, data, "attack",count49*0.04)
end
-- 攻击结束
function Skill331802:OnAttackOver(caster, target, data)
	-- 331808
	self:tFunc_331808_331806(caster, target, data)
	self:tFunc_331808_331807(caster, target, data)
end
function Skill331802:tFunc_331808_331806(caster, target, data)
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
	-- 331806
	self:AddSp(SkillEffect[331806], caster, self.card, data, 10)
end
function Skill331802:tFunc_331808_331807(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8074
	if SkillJudger:TargetIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 331807
	self:AddSp(SkillEffect[331807], caster, target, data, 10)
end
