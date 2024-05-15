-- 震荡
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4100305 = oo.class(SkillBase)
function Skill4100305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4100305:OnBefourHurt(caster, target, data)
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
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 4100305
	self:AddTempAttr(SkillEffect[4100305], caster, self.card, data, "attack",count49*0.10)
	-- 4100306
	self:ShowTips(SkillEffect[4100306], caster, self.card, data, 2,"震荡",true,4100306)
end
