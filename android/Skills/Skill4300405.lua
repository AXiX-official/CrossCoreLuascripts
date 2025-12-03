-- 卡尼斯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4300405 = oo.class(SkillBase)
function Skill4300405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4300405:OnBefourHurt(caster, target, data)
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
	-- 300400319
	local count300400314 = SkillApi:GetCount(self, caster, target,2,300400314)
	-- 4300405
	self:AddTempAttr(SkillEffect[4300405], caster, self.card, data, "damage",0.12*count300400314)
end
