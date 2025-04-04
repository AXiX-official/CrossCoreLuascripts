-- 高卡萨斯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4502505 = oo.class(SkillBase)
function Skill4502505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4502505:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4502506
	self:AddBuff(SkillEffect[4502506], caster, self.card, data, 6208)
end
-- 回合结束时
function Skill4502505:OnRoundOver(caster, target, data)
	-- 8237
	if SkillJudger:IsCasterMech(self, caster, self.card, true,5) then
	else
		return
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4502505
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:CallOwnerSkill(SkillEffect[4502505], caster, target, data, 502500405)
	end
end
-- 伤害前
function Skill4502505:OnBefourHurt(caster, target, data)
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
	-- 8416
	local count16 = SkillApi:BuffCount(self, caster, target,2,2,2)
	-- 8108
	if SkillJudger:Greater(self, caster, self.card, true,count16,0) then
	else
		return
	end
	-- 4502515
	self:AddTempAttr(SkillEffect[4502515], caster, self.card, data, "damage",0.30)
end
-- 回合开始时
function Skill4502505:OnRoundBegin(caster, target, data)
	-- 8237
	if SkillJudger:IsCasterMech(self, caster, self.card, true,5) then
	else
		return
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4502525
	self:AddBuff(SkillEffect[4502525], caster, caster, data, 4502515)
end
