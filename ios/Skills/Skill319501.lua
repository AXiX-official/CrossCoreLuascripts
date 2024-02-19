-- 反扑陷阱
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill319501 = oo.class(SkillBase)
function Skill319501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill319501:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 319501
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[319501], caster, target, data, 319501)
	end
	-- 319511
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[319511], caster, target, data, 319511)
	end
end
