-- 提泽纳boss技能1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913800101 = oo.class(SkillBase)
function Skill913800101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill913800101:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill913800101:OnAttackOver(caster, target, data)
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
	-- 913800101
	self:HitAddBuffCount(SkillEffect[913800101], caster, target, data, 10000,913800101,1,20)
end
