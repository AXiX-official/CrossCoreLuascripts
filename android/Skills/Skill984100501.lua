-- 巨蟹座普通形态技能5
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984100501 = oo.class(SkillBase)
function Skill984100501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill984100501:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
