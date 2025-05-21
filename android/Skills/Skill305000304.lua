-- 护盾爆炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305000304 = oo.class(SkillBase)
function Skill305000304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305000304:DoSkill(caster, target, data)
	-- 305000301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[305000301], caster, self.card, data, 305000301)
	-- 305000310
	self.order = self.order + 1
	self:ChangeSkill(SkillEffect[305000310], caster, self.card, data, 3,305000401)
end
-- 攻击结束
function Skill305000304:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 305000321
	self:AddBuff(SkillEffect[305000321], caster, self.card, data, 305000321)
	-- 305000320
	local count320 = SkillApi:BuffCount(self, caster, self.card,3,3,305000321)
	-- 305000322
	if SkillJudger:Greater(self, caster, self.card, true,count320,5) then
	else
		return
	end
	-- 305000323
	self:ChangeSkill(SkillEffect[305000323], caster, self.card, data, 3,305000501)
end
