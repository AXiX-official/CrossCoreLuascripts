-- 红技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill750200301 = oo.class(SkillBase)
function Skill750200301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill750200301:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
