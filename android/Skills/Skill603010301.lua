-- 莫拉鲁塔技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603010301 = oo.class(SkillBase)
function Skill603010301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603010301:DoSkill(caster, target, data)
	-- 11008
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11008], caster, target, data, 0.125,8)
end
-- 攻击结束
function Skill603010301:OnAttackOver(caster, target, data)
	-- 8732
	local count732 = SkillApi:SkillLevel(self, caster, target,3,603010101)
	-- 8731
	local count731 = SkillApi:GetCount(self, caster, target,3,603000101)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 603010301
	if self:Rand(3000+1000*count731) then
		self:CallSkill(SkillEffect[603010301], caster, target, data, 603010101+count732)
	end
end
