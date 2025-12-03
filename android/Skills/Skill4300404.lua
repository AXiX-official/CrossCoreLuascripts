-- 卡尼斯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4300404 = oo.class(SkillBase)
function Skill4300404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4300404:OnBefourHurt(caster, target, data)
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
	-- 300400318
	local count300400313 = SkillApi:GetCount(self, caster, target,2,300400313)
	-- 4300404
	self:AddTempAttr(SkillEffect[4300404], caster, self.card, data, "damage",0.10*count300400313)
end
