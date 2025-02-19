-- 人马机神高速形态5技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913110501 = oo.class(SkillBase)
function Skill913110501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill913110501:DoSkill(caster, target, data)
	-- 13016
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[13016], caster, target, data, 0.125,4)
	-- 13017
	self.order = self.order + 1
	self:DamageLight(SkillEffect[13017], caster, target, data, 0.125,4)
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
	-- 913110803
	self.order = self.order + 1
	self:AddProgress(SkillEffect[913110803], caster, target, data, -200)
end
-- 伤害前
function Skill913110501:OnBefourHurt(caster, target, data)
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
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 8408
	local count8 = SkillApi:GetAttr(self, caster, target,2,"speed")
	-- 913110602
	self:AddTempAttr(SkillEffect[913110602], caster, caster, data, "damage",math.max((count8-count7)*0.025,-0.3))
end
