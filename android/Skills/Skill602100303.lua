-- 龙弦3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill602100303 = oo.class(SkillBase)
function Skill602100303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill602100303:DoSkill(caster, target, data)
	-- 11401
	self.order = self.order + 1
	local targets = SkillFilter:Different(self, caster, target, 4,8)
	for i,target in ipairs(targets) do
		-- 11402
		self:DamageLight(SkillEffect[11402], caster, target, data, 1,1)
		-- 11403
		self:AddOrder(SkillEffect[11403], caster, target, data, nil)
		-- 8331
		self:AddValue(SkillEffect[8331], caster, target, data, "suaijian",1)
	end
	-- 8332
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DelValue(SkillEffect[8332], caster, target, data, "suaijian")
	end
end
-- 伤害前
function Skill602100303:OnBefourHurt(caster, target, data)
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
	-- 8333
	local suaijian = SkillApi:GetValue(self, caster, target,2,"suaijian")
	-- 8334
	if SkillJudger:Greater(self, caster, self.card, true,suaijian,0) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 602100301
	self:AddTempAttr(SkillEffect[602100301], caster, self.card, data, "damage",-0.40)
end
-- 攻击结束
function Skill602100303:OnAttackOver(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8092
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.7) then
	else
		return
	end
	-- 8718
	local count718 = SkillApi:SkillLevel(self, caster, target,3,6021001)
	-- 602100302
	self:CallSkill(SkillEffect[602100302], caster, self.card, data, 602100100+count718)
end
