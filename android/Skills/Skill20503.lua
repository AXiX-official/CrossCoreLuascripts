-- 眩晕III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill20503 = oo.class(SkillBase)
function Skill20503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill20503:OnBefourHurt(caster, target, data)
	-- 20523
	self:tFunc_20523_20503(caster, target, data)
	self:tFunc_20523_20513(caster, target, data)
end
function Skill20503:tFunc_20523_20513(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 8408
	local count8 = SkillApi:GetAttr(self, caster, target,2,"speed")
	-- 20513
	self:AddTempAttr(SkillEffect[20513], caster, caster, data, "damage",math.min(math.abs(count7-count8)*0.006,0.6))
end
function Skill20503:tFunc_20523_20503(caster, target, data)
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
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 8408
	local count8 = SkillApi:GetAttr(self, caster, target,2,"speed")
	-- 20503
	self:AddTempAttr(SkillEffect[20503], caster, self.card, data, "damage",math.min(math.abs(count7-count8)*0.006,0.6))
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
	-- 8433
	local count33 = SkillApi:BuffCount(self, caster, target,2,3,3004)
	-- 8116
	if SkillJudger:Greater(self, caster, self.card, true,count33,0) then
	else
		return
	end
	-- 205010
	self:ShowTips(SkillEffect[205010], caster, self.card, data, 2,"重击",true,205010)
end
