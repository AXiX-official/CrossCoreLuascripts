-- 科拉达boss特性技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913910501 = oo.class(SkillBase)
function Skill913910501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill913910501:OnActionOver(caster, target, data)
	-- 913910505
	self:tFunc_913910505_913910501(caster, target, data)
	self:tFunc_913910505_913910502(caster, target, data)
	self:tFunc_913910505_913910503(caster, target, data)
	self:tFunc_913910505_913910511(caster, target, data)
end
-- 伤害前
function Skill913910501:OnBefourHurt(caster, target, data)
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
	-- 913910106
	local countKeLaDa = SkillApi:GetCount(self, caster, target,2,913910101)
	-- 913910106
	local countKeLaDa = SkillApi:GetCount(self, caster, target,2,913910101)
	-- 913910512
	if SkillJudger:Greater(self, caster, target, true,countKeLaDa,0) then
	else
		return
	end
	-- 913910509
	self:AddTempAttr(SkillEffect[913910509], caster, self.card, data, "damage",0.02*countKeLaDa)
end
function Skill913910501:tFunc_913910505_913910501(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 913900506
	if SkillJudger:Less(self, caster, self.card, true,count18,30) then
	else
		return
	end
	-- 913910501
	local targets = SkillFilter:MinAttr(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[913910501], caster, target, data, 913900101)
	end
end
function Skill913910501:tFunc_913910505_913910502(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 913900507
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count18,30) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8931
	if SkillJudger:Less(self, caster, self.card, true,count18,50) then
	else
		return
	end
	-- 913910502
	local targets = SkillFilter:MinAttr(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[913910502], caster, target, data, 913900201)
	end
end
function Skill913910501:tFunc_913910505_913910503(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8932
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count18,50) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8933
	if SkillJudger:Less(self, caster, self.card, true,count18,100) then
	else
		return
	end
	-- 913910503
	self:CallOwnerSkill(SkillEffect[913910503], caster, target, data, 913900301)
end
function Skill913910501:tFunc_913910505_913910511(caster, target, data)
	-- 913910511
	self:AddSp(SkillEffect[913910511], caster, self.card, data, -100)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8934
	if SkillJudger:GreaterEqual(self, caster, self.card, true,count18,100) then
	else
		return
	end
	-- 913910504
	self:CallOwnerSkill(SkillEffect[913910504], caster, target, data, 913900401)
end
