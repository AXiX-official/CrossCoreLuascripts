-- 天赋效果300501
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300501 = oo.class(SkillBase)
function Skill300501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill300501:OnBefourHurt(caster, target, data)
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
	-- 8405
	local count5 = SkillApi:PercentHp(self, caster, target,1)
	-- 300501
	self:AddTempAttr(SkillEffect[300501], caster, self.card, data, "damage",math.min((1-count5)*0.1,0.1))
end
