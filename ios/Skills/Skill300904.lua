-- 天赋效果300904
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill300904 = oo.class(SkillBase)
function Skill300904:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill300904:OnBefourHurt(caster, target, data)
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
	-- 8410
	local count10 = SkillApi:BuffCount(self, caster, target,2,1,3)
	-- 300904
	self:AddTempAttr(SkillEffect[300904], caster, self.card, data, "damage",count10*0.10)
end
