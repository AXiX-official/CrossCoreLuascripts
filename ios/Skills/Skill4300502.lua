-- 暴怒
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4300502 = oo.class(SkillBase)
function Skill4300502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4300502:OnBefourHurt(caster, target, data)
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
	-- 4300502
	self:AddTempAttr(SkillEffect[4300502], caster, self.card, data, "damage",math.min((1-count5)*0.7,0.7))
	-- 4300506
	self:ShowTips(SkillEffect[4300506], caster, self.card, data, 2,"暴怒",true,4300506)
end
