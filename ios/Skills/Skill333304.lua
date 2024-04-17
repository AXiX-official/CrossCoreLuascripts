-- 刺蝽4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill333304 = oo.class(SkillBase)
function Skill333304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill333304:OnBorn(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 333304
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:SetValue(SkillEffect[333304], caster, target, data, "LimitDamage1003",0.4)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill333304:OnBornSpecial(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 326504
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:SetValue(SkillEffect[326504], caster, target, data, "LimitDamage1002",0.4)
	end
end
