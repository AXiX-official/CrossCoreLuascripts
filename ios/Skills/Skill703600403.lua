-- 被动+盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703600403 = oo.class(SkillBase)
function Skill703600403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703600403:DoSkill(caster, target, data)
	-- 703600403
	self.order = self.order + 1
	local targets = SkillFilter:MinPercentHp(self, caster, target, 1,"hp",1)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[703600403], caster, target, data, 2119,2)
	end
end
