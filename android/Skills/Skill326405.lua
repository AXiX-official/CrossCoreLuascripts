-- 火裂
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill326405 = oo.class(SkillBase)
function Skill326405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill326405:OnBefourHurt(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8428
	local count28 = SkillApi:BuffCount(self, caster, target,2,3,1002)
	-- 8111
	if SkillJudger:Greater(self, caster, self.card, true,count28,0) then
	else
		return
	end
	-- 326405
	self:AddTempAttr(SkillEffect[326405], caster, caster, data, "damage",0.3)
end
