-- 巨大稽查者被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911900601 = oo.class(SkillBase)
function Skill911900601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill911900601:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 攻击结束2
function Skill911900601:OnAttackOver2(caster, target, data)
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
	-- 8419
	local count19 = SkillApi:GetAttr(self, caster, target,3,"xp")
	-- 907800704
	if SkillJudger:Equal(self, caster, self.card, true,count19,4) then
	else
		return
	end
	-- 911900601
	self:CallSkill(SkillEffect[911900601], caster, self.card, data, 911900201)
	-- 907800603
	self:AddXp(SkillEffect[907800603], caster, self.card, data, -4)
end
-- 入场时
function Skill911900601:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 907800801
	self:AddBuff(SkillEffect[907800801], caster, self.card, data, 907800801)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 907800901
	self:AddBuff(SkillEffect[907800901], caster, self.card, data, 907800901)
end
-- 伤害后
function Skill911900601:OnAfterHurt(caster, target, data)
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
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 911900603
	if self:Rand(8000) then
		self:AddProgress(SkillEffect[911900603], caster, self.card, data, 100)
	end
end
-- 行动结束
function Skill911900601:OnActionOver(caster, target, data)
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
	-- 907800609
	if self:Rand(5000) then
		self:AddXp(SkillEffect[907800609], caster, self.card, data, 1)
	end
end
