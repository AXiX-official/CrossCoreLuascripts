-- 伊根1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4603501 = oo.class(SkillBase)
function Skill4603501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4603501:OnRoundBegin(caster, target, data)
	-- 4603501
	self:AddBuffCount(SkillEffect[4603501], caster, self.card, data, 4603501,1,999)
end
-- 回合结束时
function Skill4603501:OnRoundOver(caster, target, data)
	-- 4603531
	self:tFunc_4603531_4603511(caster, target, data)
	self:tFunc_4603531_4603521(caster, target, data)
end
-- 攻击结束2
function Skill4603501:OnAttackOver2(caster, target, data)
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
	-- 8427
	local count27 = SkillApi:BuffCount(self, caster, target,2,3,1001)
	-- 8122
	if SkillJudger:Greater(self, caster, self.card, true,count27,4) then
	else
		return
	end
	-- 4603541
	self:ClosingBuffByID(SkillEffect[4603541], caster, target, data, 1,1001)
end
function Skill4603501:tFunc_4603531_4603521(caster, target, data)
	-- 8738
	local count738 = SkillApi:SkillLevel(self, caster, target,3,6035002)
	-- 8737
	local count737 = SkillApi:GetCount(self, caster, target,3,4603501)
	-- 8737
	local count737 = SkillApi:GetCount(self, caster, target,3,4603501)
	-- 8949
	if SkillJudger:Equal(self, caster, target, true,count737%2,0) then
	else
		return
	end
	-- 4603521
	if self:Rand(1000+count737*100) then
		local targets = SkillFilter:Rand(self, caster, target, 4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[4603521], caster, target, data, 603500401+math.max(count738-1,0))
		end
	end
end
function Skill4603501:tFunc_4603531_4603511(caster, target, data)
	-- 8738
	local count738 = SkillApi:SkillLevel(self, caster, target,3,6035002)
	-- 8737
	local count737 = SkillApi:GetCount(self, caster, target,3,4603501)
	-- 8737
	local count737 = SkillApi:GetCount(self, caster, target,3,4603501)
	-- 8950
	if SkillJudger:Equal(self, caster, target, true,count737%2,1) then
	else
		return
	end
	-- 4603511
	if self:Rand(1000+count737*100) then
		local targets = SkillFilter:Rand(self, caster, target, 4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[4603511], caster, target, data, 603500201+math.max(count738-1,0))
		end
	end
end
