-- 迅斩
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill500300103 = oo.class(SkillBase)
function Skill500300103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill500300103:DoSkill(caster, target, data)
	-- 12003
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12003], caster, target, data, 0.333,3)
end
