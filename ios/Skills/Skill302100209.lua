-- 苦痛占卜
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302100209 = oo.class(SkillBase)
function Skill302100209:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill302100209:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 行动结束
function Skill302100209:OnActionOver(caster, target, data)
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
	-- 302100209
	self:HitAddBuff(SkillEffect[302100209], caster, target, data, 6800,3008)
end
