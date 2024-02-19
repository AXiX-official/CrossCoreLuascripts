-- 阿努比斯技能3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703301303 = oo.class(SkillBase)
function Skill703301303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703301303:DoSkill(caster, target, data)
	-- 12005
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12005], caster, target, data, 0.2,5)
end
-- 行动结束2
function Skill703301303:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 703300303
	self:AddBuff(SkillEffect[703300303], caster, self.card, data, 703300301,2)
end
-- 攻击结束
function Skill703301303:OnAttackOver(caster, target, data)
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
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8467
	local count67 = SkillApi:GetAttr(self, caster, target,2,"hp")
	-- 8189
	if SkillJudger:Greater(self, caster, target, true,count20,count67) then
	else
		return
	end
	-- 8467
	local count67 = SkillApi:GetAttr(self, caster, target,2,"hp")
	-- 8667
	local count667 = SkillApi:BuffCount(self, caster, target,3,4,703300301)
	-- 8877
	if SkillJudger:Greater(self, caster, target, true,count667,0) then
	else
		return
	end
	-- 703300301
	if self:Rand(500) then
		self:AddHp(SkillEffect[703300301], caster, target, data, -count67,1)
	end
end
