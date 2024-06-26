-- 刺蝽3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill503000303 = oo.class(SkillBase)
function Skill503000303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill503000303:DoSkill(caster, target, data)
	-- 11005
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11005], caster, target, data, 0.2,5)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill503000303:OnBefourCritHurt(caster, target, data)
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
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8112
	if SkillJudger:Greater(self, caster, self.card, true,count29,0) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 503000301
	self:AddTempAttr(SkillEffect[503000301], caster, self.card, data, "crit_rate",0.15)
	-- 503000302
	self:AddTempAttr(SkillEffect[503000302], caster, self.card, data, "crit",0.3)
end
