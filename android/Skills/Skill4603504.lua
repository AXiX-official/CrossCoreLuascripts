-- 伊根
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4603504 = oo.class(SkillBase)
function Skill4603504:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4603504:OnRoundBegin(caster, target, data)
	-- 4603501
	self:AddBuffCount(SkillEffect[4603501], caster, self.card, data, 4603501,1,999)
end
-- 回合结束时
function Skill4603504:OnRoundOver(caster, target, data)
	-- 4603534
	self:tFunc_4603534_4603514(caster, target, data)
	self:tFunc_4603534_4603524(caster, target, data)
end
-- 攻击结束2
function Skill4603504:OnAttackOver2(caster, target, data)
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
	-- 4603542
	self:ClosingBuffByID(SkillEffect[4603542], caster, target, data, 2,1001)
end
function Skill4603504:tFunc_4603534_4603514(caster, target, data)
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
	-- 4603514
	if self:Rand(4000+count737*100) then
		local targets = SkillFilter:Rand(self, caster, target, 4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[4603514], caster, target, data, 603500201+math.max(count738-1,0))
		end
	end
end
function Skill4603504:tFunc_4603534_4603524(caster, target, data)
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
	-- 4603524
	if self:Rand(4000+count737*100) then
		local targets = SkillFilter:Rand(self, caster, target, 4)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[4603524], caster, target, data, 603500401+math.max(count738-1,0))
		end
	end
end
