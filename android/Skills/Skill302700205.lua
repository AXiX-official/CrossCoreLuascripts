-- 技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302700205 = oo.class(SkillBase)
function Skill302700205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill302700205:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 攻击结束
function Skill302700205:OnAttackOver(caster, target, data)
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
	-- 302700203
	self:AddProgress(SkillEffect[302700203], caster, target, data, -200)
end
