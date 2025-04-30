-- 护盾爆炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305000305 = oo.class(SkillBase)
function Skill305000305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305000305:DoSkill(caster, target, data)
	-- 305000301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[305000301], caster, target, data, 305000301)
	-- 305000310
	self.order = self.order + 1
	self:ChangeSkill(SkillEffect[305000310], caster, target, data, 3,305000401)
end
-- 攻击结束
function Skill305000305:OnAttackOver(caster, target, data)
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
	local count320 = SkillApi:BuffCount(self, caster, target,3,3,305000321)
	-- 305000322
	if SkillJudger:Greater(self, caster, target, true,count320,5) then
	else
		return
	end
	-- 305000323
	self:ChangeSkill(SkillEffect[305000323], caster, self.card, data, 3,305000501)
end
