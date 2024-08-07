-- 冰枪横扫（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill602801305 = oo.class(SkillBase)
function Skill602801305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill602801305:DoSkill(caster, target, data)
	-- 11003
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11003], caster, target, data, 0.333,3)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 行动结束
function Skill602801305:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 602800302
	self:Cure(SkillEffect[602800302], caster, self.card, data, 4,0.3)
end
