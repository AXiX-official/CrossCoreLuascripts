-- 放逐者1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill803500101 = oo.class(SkillBase)
function Skill803500101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill803500101:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 攻击结束
function Skill803500101:OnAttackOver(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 803500101
	self:HitAddBuff(SkillEffect[803500101], caster, target, data, 5000,5104)
end
