-- 审判攻击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305000405 = oo.class(SkillBase)
function Skill305000405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305000405:DoSkill(caster, target, data)
	-- 11003
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
end
-- 攻击结束
function Skill305000405:OnAttackOver(caster, target, data)
	-- 305000401
	self:AddBuff(SkillEffect[305000401], caster, target, data, 305000401)
	-- 305000610
	self:ChangeSkill(SkillEffect[305000610], caster, target, data, 3,305000301)
	-- 305000510
	self:DelBufferForce(SkillEffect[305000510], caster, self.card, data, 305000321)
	-- 305000320
	local count320 = SkillApi:BuffCount(self, caster, target,3,3,305000321)
	-- 305000322
	if SkillJudger:Greater(self, caster, target, true,count320,5) then
	else
		return
	end
	-- 305000410
	self:AddBuffCount(SkillEffect[305000410], caster, self.card, data, 305000410,1,5)
	-- 305000510
	self:DelBufferForce(SkillEffect[305000510], caster, self.card, data, 305000321)
end
