-- 爪击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300500102 = oo.class(SkillBase)
function Skill300500102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill300500102:DoSkill(caster, target, data)
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
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8526
	self.order = self.order + 1
	self:AddHp(SkillEffect[8526], caster, self.card, data, -math.floor(count20*0.1))
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
end
