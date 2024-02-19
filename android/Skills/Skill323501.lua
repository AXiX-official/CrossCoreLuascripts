-- 冰爆
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill323501 = oo.class(SkillBase)
function Skill323501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill323501:OnBefourHurt(caster, target, data)
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
	-- 8434
	local count34 = SkillApi:BuffCount(self, caster, target,2,3,3005)
	-- 8117
	if SkillJudger:Greater(self, caster, self.card, true,count34,0) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 323501
	self:AddTempAttr(SkillEffect[323501], caster, self.card, data, "damage",0.4)
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
	-- 323511
	self:DelBufferForce(SkillEffect[323511], caster, target, data, 3005)
end
