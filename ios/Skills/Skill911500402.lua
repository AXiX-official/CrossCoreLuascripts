-- 耐寒特性
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911500402 = oo.class(SkillBase)
function Skill911500402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill911500402:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill911500402:OnAttackOver(caster, target, data)
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
	-- 911500401
	self:OwnerAddBuffCount(SkillEffect[911500401], caster, target, data, 907700401,1,8)
end
-- 伤害前
function Skill911500402:OnBefourHurt(caster, target, data)
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
	-- 8412
	local count12 = SkillApi:BuffCount(self, caster, target,2,1,2)
	-- 8187
	if SkillJudger:Greater(self, caster, target, true,count12,0) then
	else
		return
	end
	-- 911500402
	self:AddTempAttr(SkillEffect[911500402], caster, self.card, data, "damage",0.4)
end
-- 行动结束
function Skill911500402:OnActionOver(caster, target, data)
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
	-- 8623
	local count623 = SkillApi:GetCount(self, caster, target,3,907700401)
	-- 8885
	if SkillJudger:GreaterEqual(self, caster, target, true,count623,4) then
	else
		return
	end
	-- 911500405
	self:BeatBack(SkillEffect[911500405], caster, target, data, 910700201)
	-- 907700404
	self:DelBufferForce(SkillEffect[907700404], caster, self.card, data, 907700401)
end
