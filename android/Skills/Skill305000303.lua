-- 护盾爆炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305000303 = oo.class(SkillBase)
function Skill305000303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305000303:DoSkill(caster, target, data)
	-- 305000301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[305000301], caster, self.card, data, 305000301)
	-- 305000310
	self.order = self.order + 1
	self:ChangeSkill(SkillEffect[305000310], caster, self.card, data, 3,305000401)
	-- 305000321
	self.order = self.order + 1
	self:AddFury(SkillEffect[305000321], caster, self.card, data, 20,100)
end
-- 攻击结束
function Skill305000303:OnAttackOver(caster, target, data)
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
	-- 305000326
	local targets = SkillFilter:All(self, caster, target, nil)
	for i,target in ipairs(targets) do
		self:AddFury(SkillEffect[305000326], caster, target, data, 10,100)
	end
end
-- 行动结束2
function Skill305000303:OnActionOver2(caster, target, data)
	-- 305000320
	local xuneng = SkillApi:GetFury(self, caster, self.card,3)
	-- 305000322
	if SkillJudger:Greater(self, caster, target, true,xuneng,100) then
		-- 305000323
		self:ChangeSkill(SkillEffect[305000323], caster, self.card, data, 3,305000501)
	end
end
