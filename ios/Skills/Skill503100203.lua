-- 幽兰2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill503100203 = oo.class(SkillBase)
function Skill503100203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill503100203:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
