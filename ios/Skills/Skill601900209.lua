-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill601900209 = oo.class(SkillBase)
function Skill601900209:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill601900209:DoSkill(caster, target, data)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	self.order = self.order + 1
	self:AddBuff(SkillEffect[601900209], caster, target, data, 4606,3)
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	self.order = self.order + 1
	self:AddBuff(SkillEffect[601900219], caster, target, data, 4906,3)
end
