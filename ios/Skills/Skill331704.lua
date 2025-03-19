-- 拉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331704 = oo.class(SkillBase)
function Skill331704:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill331704:OnBefourHurt(caster, target, data)
	-- 331704
	self:tFunc_331704_331724(caster, target, data)
	self:tFunc_331704_331714(caster, target, data)
end
function Skill331704:tFunc_331704_331714(caster, target, data)
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
	-- 331714
	self:AddTempAttr(SkillEffect[331714], caster, caster, data, "attack",count49*0.04)
end
function Skill331704:tFunc_331704_331724(caster, target, data)
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
	-- 331724
	self:AddTempAttr(SkillEffect[331724], caster, caster, data, "attack",count49*0.08)
end
