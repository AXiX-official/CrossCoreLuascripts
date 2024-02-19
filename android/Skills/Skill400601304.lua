-- 晦霭隐氤（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill400601304 = oo.class(SkillBase)
function Skill400601304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill400601304:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
-- 伤害前
function Skill400601304:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 999999989
	self:AddTempAttr(SkillEffect[999999989], caster, self.card, data, "damage",count7*0.006)
end
-- 攻击开始
function Skill400601304:OnAttackBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 400600302
	self:HitAddBuff(SkillEffect[400600302], caster, target, data, 7500,5903,2)
end
