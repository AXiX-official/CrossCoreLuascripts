-- 洛贝拉（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603301302 = oo.class(SkillBase)
function Skill603301302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603301302:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
-- 伤害前
function Skill603301302:OnBefourHurt(caster, target, data)
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
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 603300101
	self:AddTempAttr(SkillEffect[603300101], caster, target, data, "defense",-200)
end
