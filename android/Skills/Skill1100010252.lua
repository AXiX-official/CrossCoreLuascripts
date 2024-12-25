-- 威胁III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010252 = oo.class(SkillBase)
function Skill1100010252:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill1100010252:OnDeath(caster, target, data)
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
	-- 1100010252
	local targets = SkillFilter:All(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:AddProgress(SkillEffect[1100010252], caster, target, data, -300)
	end
end
