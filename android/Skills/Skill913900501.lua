-- 科拉达boss特性技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913900501 = oo.class(SkillBase)
function Skill913900501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill913900501:OnActionOver(caster, target, data)
	-- 913900505
	self:tFunc_913900505_913900501(caster, target, data)
	self:tFunc_913900505_913900502(caster, target, data)
	self:tFunc_913900505_913900503(caster, target, data)
	self:tFunc_913900505_913900511(caster, target, data)
end
-- 入场时
function Skill913900501:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4803605
	self:AddBuff(SkillEffect[4803605], caster, self.card, data, 4803605)
end
function Skill913900501:tFunc_913900505_913900501(caster, target, data)
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
	-- 913900501
	local targets = SkillFilter:MinAttr(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[913900501], caster, target, data, 913900101)
	end
end
function Skill913900501:tFunc_913900505_913900503(caster, target, data)
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
	-- 913900503
	self:CallOwnerSkill(SkillEffect[913900503], caster, target, data, 913900301)
end
function Skill913900501:tFunc_913900505_913900502(caster, target, data)
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
	-- 913900502
	local targets = SkillFilter:MinAttr(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[913900502], caster, target, data, 913900201)
	end
end
function Skill913900501:tFunc_913900505_913900511(caster, target, data)
	-- 913900511
	self:AddSp(SkillEffect[913900511], caster, self.card, data, -100)
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
	-- 913900504
	self:CallOwnerSkill(SkillEffect[913900504], caster, target, data, 913900401)
end
