-- 反击强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill323103 = oo.class(SkillBase)
function Skill323103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill323103:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8418
	local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 323103
	self:AddTempAttr(SkillEffect[323103], caster, self.card, data, "damage",count18*0.003)
end
