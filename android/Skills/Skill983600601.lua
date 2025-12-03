-- 引力神光
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983600601 = oo.class(SkillBase)
function Skill983600601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill983600601:DoSkill(caster, target, data)
	-- 8476
	local count76 = SkillApi:LiveCount(self, caster, target,3)
	-- 8801
	if SkillJudger:Equal(self, caster, target, true,count76,1) then
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
	-- 110008031
	self.order = self.order + 1
	self:CallSkill(SkillEffect[110008031], caster, self.card, data, 983600501)
	-- 110008032
	self.order = self.order + 1
	self:CallSkill(SkillEffect[110008032], caster, self.card, data, 983600201)
end
