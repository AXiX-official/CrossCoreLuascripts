-- 肉鸽乐团阵营技能附带血量伤害（金色2级别）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020051 = oo.class(SkillBase)
function Skill1100020051:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100020051:OnBefourHurt(caster, target, data)
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
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 1100020051
	self:AddHp(SkillEffect[1100020051], caster, target, data, -count20*0.1)
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
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 1100020054
	self:AddHp(SkillEffect[1100020054], caster, caster, data, -count20*0.01)
end
