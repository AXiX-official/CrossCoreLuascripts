-- 反扑陷阱
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill319503 = oo.class(SkillBase)
function Skill319503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill319503:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 319503
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[319503], caster, target, data, 319503)
	end
	-- 319511
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[319511], caster, target, data, 319511)
	end
end
