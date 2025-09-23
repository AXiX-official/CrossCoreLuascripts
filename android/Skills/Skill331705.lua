-- 拉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331705 = oo.class(SkillBase)
function Skill331705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill331705:OnBefourHurt(caster, target, data)
	-- 331705
	self:tFunc_331705_331725(caster, target, data)
	self:tFunc_331705_331715(caster, target, data)
end
function Skill331705:tFunc_331705_331715(caster, target, data)
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
	-- 331715
	self:AddTempAttr(SkillEffect[331715], caster, caster, data, "attack",math.min((count49*0.05),2500))
end
function Skill331705:tFunc_331705_331725(caster, target, data)
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
	-- 331725
	self:AddTempAttr(SkillEffect[331725], caster, caster, data, "attack",math.min((count49*0.1),5000))
end
