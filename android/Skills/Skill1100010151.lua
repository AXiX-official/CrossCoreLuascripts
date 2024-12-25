-- 耐久转化2级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010151 = oo.class(SkillBase)
function Skill1100010151:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100010151:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 1100010151
	self:AddTempAttr(SkillEffect[1100010151], caster, self.card, data, "attack",count49*0.05)
end
