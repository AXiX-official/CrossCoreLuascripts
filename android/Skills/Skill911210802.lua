-- 克拉肯-狂暴多队战斗技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911210802 = oo.class(SkillBase)
function Skill911210802:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill911210802:OnActionBegin(caster, target, data)
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8904
	if SkillJudger:LessEqual(self, caster, target, true,count76,3) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 93002
	if SkillJudger:CheckCD(self, caster, target, false) then
	else
		return
	end
	-- 911210211
	self:CallSkill(SkillEffect[911210211], caster, target, data, 911210202)
	-- 93001
	self:ResetCD(SkillEffect[93001], caster, target, data, 2)
end
