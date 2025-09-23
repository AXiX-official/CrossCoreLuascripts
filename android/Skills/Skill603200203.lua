-- 赫格尼技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603200203 = oo.class(SkillBase)
function Skill603200203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603200203:DoSkill(caster, target, data)
	-- 30002
	self.order = self.order + 1
	local targets = SkillFilter:All(self, caster, target, 1)
	for i,target in ipairs(targets) do
		self:Cure(SkillEffect[30002], caster, target, data, 1,0.1)
	end
	-- 4003
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4003], caster, target, data, 4003)
end
