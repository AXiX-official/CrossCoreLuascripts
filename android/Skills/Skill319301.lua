-- 转速耦合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill319301 = oo.class(SkillBase)
function Skill319301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill319301:OnBefourHurt(caster, target, data)
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
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 8408
	local count8 = SkillApi:GetAttr(self, caster, target,2,"speed")
	-- 319301
	self:AddTempAttr(SkillEffect[319301], caster, self.card, data, "damage",math.max((count7-count8)*0.002,0.01))
end
