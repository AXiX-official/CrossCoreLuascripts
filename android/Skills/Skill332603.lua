-- ccc4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill332603 = oo.class(SkillBase)
function Skill332603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill332603:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8223
	if SkillJudger:IsDamageType(self, caster, target, true,2) then
	else
		return
	end
	-- 332606
	self:AddTempAttr(SkillEffect[332606], caster, caster, data, "damage",-0.20)
end
-- 伤害后
function Skill332603:OnAfterHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8421
	local count21 = SkillApi:GetLastHitDamage(self, caster, target,1)
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 8882
	if SkillJudger:Greater(self, caster, target, true,count21-count49*0.1,0) then
	else
		return
	end
	-- 332603
	self:AddBuffCount(SkillEffect[332603], caster, self.card, data, 332603,1,5)
end
-- 行动结束2
function Skill332603:OnActionOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 332607
	self:DelBufferTypeForce(SkillEffect[332607], caster, self.card, data, 332601)
end
