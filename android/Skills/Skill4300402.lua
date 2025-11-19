-- 卡尼斯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4300402 = oo.class(SkillBase)
function Skill4300402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4300402:OnBefourHurt(caster, target, data)
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
	-- 4300406
	local count4300406 = SkillApi:BuffCount(self, caster, target,2,3,300400302)
	-- 4300407
	local count4300407 = SkillApi:BuffCount(self, caster, target,2,3,300400303)
	-- 4300402
	self:AddTempAttr(SkillEffect[4300402], caster, self.card, data, "damage",0.12*(count4300406+count4300407))
end
