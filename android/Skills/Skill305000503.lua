-- 轰炸攻击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305000503 = oo.class(SkillBase)
function Skill305000503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305000503:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
end
-- 攻击结束
function Skill305000503:OnAttackOver(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 305000501
	self:AddTempAttr(SkillEffect[305000501], caster, self.card, data, "damagePhysics",8)
	-- 305000610
	self:ChangeSkill(SkillEffect[305000610], caster, self.card, data, 3,305000301)
	-- 305000510
	self:SetFury(SkillEffect[305000510], caster, self.card, data, 0)
	-- 305000511
	self:DelBufferForce(SkillEffect[305000511], caster, self.card, data, 305000301)
end
