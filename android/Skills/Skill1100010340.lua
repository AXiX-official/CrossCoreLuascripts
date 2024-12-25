-- 肉鸽山脉阵营碎星角色buff1（金色1级别）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010340 = oo.class(SkillBase)
function Skill1100010340:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill1100010340:OnAfterHurt(caster, target, data)
	-- 1100010340
	self:tFunc_1100010340_1100010341(caster, target, data)
	self:tFunc_1100010340_1100010342(caster, target, data)
	self:tFunc_1100010340_1100010343(caster, target, data)
end
-- 伤害前
function Skill1100010340:OnBefourHurt(caster, target, data)
	-- 11000103400
	self:tFunc_11000103400_1100010344(caster, target, data)
	self:tFunc_11000103400_1100010345(caster, target, data)
	self:tFunc_11000103400_1100010346(caster, target, data)
end
-- 入场时
function Skill1100010340:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8229
	if SkillJudger:IsCasterMech(self, caster, self.card, true,1) then
	else
		return
	end
	-- 1100010360
	self:AddBuff(SkillEffect[1100010360], caster, caster, data, 1100010360)
end
function Skill1100010340:tFunc_11000103400_1100010345(caster, target, data)
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
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 8241
	if SkillJudger:IsCasterMech(self, caster, self.card, true,7) then
	else
		return
	end
	-- 1100010345
	self:OwnerAddBuffCount(SkillEffect[1100010345], caster, target, data, 1100010340,-1,10)
end
function Skill1100010340:tFunc_1100010340_1100010343(caster, target, data)
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 8229
	if SkillJudger:IsCasterMech(self, caster, self.card, true,1) then
	else
		return
	end
	-- 1100010343
	self:OwnerAddBuffCount(SkillEffect[1100010343], caster, target, data, 1100010340,1,10)
end
function Skill1100010340:tFunc_1100010340_1100010342(caster, target, data)
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
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 8229
	if SkillJudger:IsCasterMech(self, caster, self.card, true,1) then
	else
		return
	end
	-- 1100010342
	self:OwnerAddBuffCount(SkillEffect[1100010342], caster, target, data, 1100010340,1,10)
end
function Skill1100010340:tFunc_1100010340_1100010341(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8229
	if SkillJudger:IsCasterMech(self, caster, self.card, true,1) then
	else
		return
	end
	-- 1100010341
	self:OwnerAddBuffCount(SkillEffect[1100010341], caster, target, data, 1100010340,1,10)
end
function Skill1100010340:tFunc_11000103400_1100010344(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8241
	if SkillJudger:IsCasterMech(self, caster, self.card, true,7) then
	else
		return
	end
	-- 1100010344
	self:OwnerAddBuffCount(SkillEffect[1100010344], caster, target, data, 1100010340,-1,10)
end
function Skill1100010340:tFunc_11000103400_1100010346(caster, target, data)
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 8241
	if SkillJudger:IsCasterMech(self, caster, self.card, true,7) then
	else
		return
	end
	-- 1100010346
	self:OwnerAddBuffCount(SkillEffect[1100010346], caster, target, data, 1100010340,-1,10)
end
