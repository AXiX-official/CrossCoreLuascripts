-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100301306 = oo.class(SkillBase)
function Skill100301306:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100301306:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11051], caster, target, data, 0.125,4)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[11052], caster, target, data, 0.25,2)
end
-- 行动结束
function Skill100301306:OnActionOver(caster, target, data)
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
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	self:AddHp(SkillEffect[999999988], caster, target, data, -count49*0.3)
end
