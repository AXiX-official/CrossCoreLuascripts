-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill501800208 = oo.class(SkillBase)
function Skill501800208:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill501800208:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 行动结束
function Skill501800208:OnActionOver(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	self:HitAddBuff(SkillEffect[302100208], caster, target, data, 6700,3008)
end
