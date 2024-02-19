-- 凝霜
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill602800405 = oo.class(SkillBase)
function Skill602800405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill602800405:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8670
	local count670 = SkillApi:GetCount(self, caster, target,3,602800206)
	-- 8879
	if SkillJudger:Less(self, caster, target, true,count670,4) then
	else
		return
	end
	-- 602800205
	self.order = self.order + 1
	self:AddBuffCount(SkillEffect[602800205], caster, self.card, data, 602800205,1,4)
	-- 602800206
	self.order = self.order + 1
	self:AddBuffCount(SkillEffect[602800206], caster, self.card, data, 602800206,1,4)
end
