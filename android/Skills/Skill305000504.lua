-- 轰炸攻击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305000504 = oo.class(SkillBase)
function Skill305000504:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305000504:DoSkill(caster, target, data)
	-- 11503
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11503], caster, target, data, 2,3)
	-- 11504
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamagePhysics(SkillEffect[11504], caster, target, data, 2.1,1)
	end
end
-- 行动结束2
function Skill305000504:OnActionOver2(caster, target, data)
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
	-- 305000401
	self:ChangeSkill(SkillEffect[305000401], caster, self.card, data, 3,305000301)
	-- 305000402
	self:SetFury(SkillEffect[305000402], caster, self.card, data, 0)
	-- 305000403
	self:DelBufferForce(SkillEffect[305000403], caster, self.card, data, 305000301)
end
-- 攻击结束
function Skill305000504:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 305000328
	local count3050 = SkillApi:BuffCount(self, caster, target,3,4,305000301)
	-- 305000327
	if SkillJudger:Greater(self, caster, target, true,count3050,0) then
	else
		return
	end
	-- 305000321
	self:AddFury(SkillEffect[305000321], caster, self.card, data, 10,100)
end
-- 行动结束
function Skill305000504:OnActionOver(caster, target, data)
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
	-- 305000328
	local count3050 = SkillApi:BuffCount(self, caster, target,3,4,305000301)
	-- 305000327
	if SkillJudger:Greater(self, caster, target, true,count3050,0) then
	else
		return
	end
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 305000325
	self:AddFury(SkillEffect[305000325], caster, self.card, data, 10,100)
end
