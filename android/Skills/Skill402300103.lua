-- 脉冲流
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill402300103 = oo.class(SkillBase)
function Skill402300103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill402300103:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
