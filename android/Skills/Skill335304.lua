-- 熔铄2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill335304 = oo.class(SkillBase)
function Skill335304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill335304:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 335301
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[335301], caster, target, data, 335301)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 335311
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[335311], caster, target, data, 335301)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill335304:OnBornSpecial(caster, target, data)
	-- 335324
	self:OwnerAddBuff(SkillEffect[335324], caster, caster, data, 335304)
end