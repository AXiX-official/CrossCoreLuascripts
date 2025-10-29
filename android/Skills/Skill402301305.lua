-- 夏炙
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill402301305 = oo.class(SkillBase)
function Skill402301305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill402301305:DoSkill(caster, target, data)
	-- 12003
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12003], caster, target, data, 0.333,3)
end
-- 攻击开始
function Skill402301305:OnAttackBegin(caster, target, data)
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
	-- 402300303
	self:AddBuff(SkillEffect[402300303], caster, target, data, 402300303)
end
