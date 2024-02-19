-- 眩光爆炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill900800301 = oo.class(SkillBase)
function Skill900800301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill900800301:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
	-- 3004
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[3004], caster, target, data, 10000,3004)
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
	-- 900800301
	self.order = self.order + 1
	self:AddHp(SkillEffect[900800301], caster, self.card, data, -count20)
end
