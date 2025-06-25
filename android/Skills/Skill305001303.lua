-- OD
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305001303 = oo.class(SkillBase)
function Skill305001303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305001303:DoSkill(caster, target, data)
	-- 11501
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11501], caster, target, data, 1,3)
	-- 11502
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamagePhysics(SkillEffect[11502], caster, target, data, 1.4,1)
	end
end
-- 伤害前
function Skill305001303:OnBefourHurt(caster, target, data)
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
	-- 305000320
	local xuneng = SkillApi:GetFury(self, caster, self.card,3)
	-- 305001301
	self:AddTempAttr(SkillEffect[305001301], caster, self.card, data, "damage",xuneng/10000*1.5)
end
-- 行动结束
function Skill305001303:OnActionOver(caster, target, data)
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
	-- 305001302
	self:SetFury(SkillEffect[305001302], caster, self.card, data, 0)
	-- 305001303
	self:ChangeSkill(SkillEffect[305001303], caster, self.card, data, 3,305000301)
end
