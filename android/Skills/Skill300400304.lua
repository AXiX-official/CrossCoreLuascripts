-- 终极爆裂
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300400304 = oo.class(SkillBase)
function Skill300400304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill300400304:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill300400304:OnAttackOver(caster, target, data)
	-- 300400306
	self:tFunc_300400306_300400303(caster, target, data)
	self:tFunc_300400306_300400304(caster, target, data)
end
function Skill300400304:tFunc_300400306_300400303(caster, target, data)
	-- 300400303
	self:tFunc_300400303_300400301(caster, target, data)
	self:tFunc_300400303_300400302(caster, target, data)
end
function Skill300400304:tFunc_300400303_300400301(caster, target, data)
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
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 984100603
	if SkillJudger:Equal(self, caster, target, true,(playerturn%2),1) then
	else
		return
	end
	-- 907800607
	local playerturn = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 907800610
	if SkillJudger:Greater(self, caster, self.card, true,playerturn,0) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 300400301
	if self:Rand(4000) then
		self:AddBuff(SkillEffect[300400301], caster, target, data, 300400302)
	end
end
