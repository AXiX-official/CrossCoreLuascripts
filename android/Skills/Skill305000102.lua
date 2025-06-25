-- SP昆仑1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305000102 = oo.class(SkillBase)
function Skill305000102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305000102:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
-- 伤害前
function Skill305000102:OnBefourHurt(caster, target, data)
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
	-- 305000102
	self:AddTempAttr(SkillEffect[305000102], caster, target, data, "defense",-240)
end
