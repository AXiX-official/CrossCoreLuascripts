-- 肉鸽山脉阵营虫洞角色buff3（金色3级别）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010352 = oo.class(SkillBase)
function Skill1100010352:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill1100010352:OnAfterHurt(caster, target, data)
	-- 1100010350
	self:tFunc_1100010350_1100010351(caster, target, data)
	self:tFunc_1100010350_1100010352(caster, target, data)
	self:tFunc_1100010350_1100010353(caster, target, data)
end
-- 伤害前
function Skill1100010352:OnBefourHurt(caster, target, data)
	-- 11000103500
	self:tFunc_11000103500_1100010354(caster, target, data)
	self:tFunc_11000103500_1100010355(caster, target, data)
	self:tFunc_11000103500_1100010356(caster, target, data)
end
-- 入场时
function Skill1100010352:OnBorn(caster, target, data)
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
	-- 1100010358
	self:AddBuff(SkillEffect[1100010358], caster, caster, data, 1100010358)
end
function Skill1100010352:tFunc_11000103500_1100010354(caster, target, data)
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
	-- 8237
	if SkillJudger:IsCasterMech(self, caster, self.card, true,5) then
	else
		return
	end
	-- 1100010354
	self:OwnerAddBuffCount(SkillEffect[1100010354], caster, target, data, 1100010350,-1,10)
end
function Skill1100010352:tFunc_11000103500_1100010356(caster, target, data)
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
	-- 8237
	if SkillJudger:IsCasterMech(self, caster, self.card, true,5) then
	else
		return
	end
	-- 1100010356
	self:OwnerAddBuffCount(SkillEffect[1100010356], caster, target, data, 1100010340,-1,10)
end
function Skill1100010352:tFunc_1100010350_1100010351(caster, target, data)
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
	-- 1100010351
	self:OwnerAddBuffCount(SkillEffect[1100010351], caster, target, data, 1100010350,1,10)
end
function Skill1100010352:tFunc_1100010350_1100010352(caster, target, data)
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
	-- 1100010352
	self:OwnerAddBuffCount(SkillEffect[1100010352], caster, target, data, 1100010350,1,10)
end
function Skill1100010352:tFunc_11000103500_1100010355(caster, target, data)
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
	-- 8237
	if SkillJudger:IsCasterMech(self, caster, self.card, true,5) then
	else
		return
	end
	-- 1100010355
	self:OwnerAddBuffCount(SkillEffect[1100010355], caster, target, data, 1100010350,-1,10)
end
function Skill1100010352:tFunc_1100010350_1100010353(caster, target, data)
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
	-- 1100010353
	self:OwnerAddBuffCount(SkillEffect[1100010353], caster, target, data, 1100010350,1,10)
end
