-- 储备III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010112 = oo.class(SkillBase)
function Skill1100010112:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100010112:OnBorn(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8221
	if SkillJudger:IsCanHurt(self, caster, target, false) then
	else
		return
	end
	-- 1100010112
	if self:Rand(10000) then
		self:AddNp(SkillEffect[1100010112], caster, caster, data, 5)
	end
end
