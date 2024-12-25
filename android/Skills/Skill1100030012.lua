-- 肉鸽不朽阵营同调伤害增加3（金色3级别）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100030012 = oo.class(SkillBase)
function Skill1100030012:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100030012:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9736
	self:tFunc_9736_9732(caster, target, data)
	self:tFunc_9736_9734(caster, target, data)
	self:tFunc_9736_9735(caster, target, data)
	self:tFunc_9736_9736(caster, target, data)
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100030012
	self:AddTempAttr(SkillEffect[1100030012], caster, caster, data, "damage",0.8)
end
-- 行动结束
function Skill1100030012:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 1100030015
	self:AddHp(SkillEffect[1100030015], caster, caster, data, -count20*0.1)
end
-- 入场时
function Skill1100030012:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9741
	self:tFunc_9741_9737(caster, target, data)
	self:tFunc_9741_9738(caster, target, data)
	self:tFunc_9741_9739(caster, target, data)
	self:tFunc_9741_9740(caster, target, data)
	-- 1100030016
	self:AddBuff(SkillEffect[1100030016], caster, self.card, data, 1100030016)
end
function Skill1100030012:tFunc_9741_9740(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9740
	if SkillJudger:IsCasterSibling(self, caster, target, true,50010) then
	else
		return
	end
end
function Skill1100030012:tFunc_9736_9734(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9734
	if SkillJudger:IsCasterSibling(self, caster, target, true,50041) then
	else
		return
	end
end
function Skill1100030012:tFunc_9736_9732(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9732
	if SkillJudger:IsCasterSibling(self, caster, target, true,30481) then
	else
		return
	end
end
function Skill1100030012:tFunc_9736_9735(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9735
	if SkillJudger:IsCasterSibling(self, caster, target, true,50011) then
	else
		return
	end
end
function Skill1100030012:tFunc_9736_9736(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9736
	self:tFunc_9736_9732(caster, target, data)
	self:tFunc_9736_9734(caster, target, data)
	self:tFunc_9736_9735(caster, target, data)
	self:tFunc_9736_9736(caster, target, data)
end
function Skill1100030012:tFunc_9741_9739(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9739
	if SkillJudger:IsCasterSibling(self, caster, target, true,50040) then
	else
		return
	end
end
function Skill1100030012:tFunc_9741_9738(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9738
	if SkillJudger:IsCasterSibling(self, caster, target, true,30430) then
	else
		return
	end
end
function Skill1100030012:tFunc_9741_9737(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9737
	if SkillJudger:IsCasterSibling(self, caster, target, true,30480) then
	else
		return
	end
end
