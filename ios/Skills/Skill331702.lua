-- 拉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331702 = oo.class(SkillBase)
function Skill331702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill331702:OnBefourHurt(caster, target, data)
	-- 331702
	self:tFunc_331702_331722(caster, target, data)
	self:tFunc_331702_331712(caster, target, data)
end
function Skill331702:tFunc_331702_331712(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 331712
	self:AddTempAttr(SkillEffect[331712], caster, caster, data, "attack",count49*0.02)
end
function Skill331702:tFunc_331702_331722(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 331722
	self:AddTempAttr(SkillEffect[331722], caster, caster, data, "attack",count49*0.04)
end
