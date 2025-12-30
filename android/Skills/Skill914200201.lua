-- 蜘蛛2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914200201 = oo.class(SkillBase)
function Skill914200201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914200201:DoSkill(caster, target, data)
	-- 12811
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12811], caster, target, data, 0.25,2)
	-- 12812
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12812], caster, target, data, 0.25,1)
	end
	-- 12813
	self.order = self.order + 1
	local targets = SkillFilter:Rand(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:DamageLight(SkillEffect[12813], caster, target, data, 0.25,1)
	end
end
