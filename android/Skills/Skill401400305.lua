-- 剑影随光
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill401400305 = oo.class(SkillBase)
function Skill401400305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill401400305:DoSkill(caster, target, data)
	-- 12005
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12005], caster, target, data, 0.2,5)
end
