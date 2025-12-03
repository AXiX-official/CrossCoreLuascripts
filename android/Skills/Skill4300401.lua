-- 卡尼斯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4300401 = oo.class(SkillBase)
function Skill4300401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4300401:OnBefourHurt(caster, target, data)
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
	-- 300400315
	local count300400310 = SkillApi:GetCount(self, caster, target,2,300400310)
	-- 4300401
	self:AddTempAttr(SkillEffect[4300401], caster, self.card, data, "damage",0.04*count300400310)
end
