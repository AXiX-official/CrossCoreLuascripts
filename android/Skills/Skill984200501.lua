-- 狮子座普通形态技能5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984200501 = oo.class(SkillBase)
function Skill984200501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill984200501:DoSkill(caster, target, data)
	-- 11004
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11004], caster, target, data, 0.25,4)
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
	-- 984200802
	local shoulie = SkillApi:GetValue(self, caster, target,2,"shoulie")
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 984200501
	self.order = self.order + 1
	self:AddTempAttr(SkillEffect[984200501], caster, target, data, "damage",2*shoulie)
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
	-- 984200502
	self.order = self.order + 1
	self:DelBufferForce(SkillEffect[984200502], caster, target, data, 984200801,30)
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
	-- 984200503
	self.order = self.order + 1
	self:DelBufferForce(SkillEffect[984200503], caster, target, data, 984200803,30)
end
