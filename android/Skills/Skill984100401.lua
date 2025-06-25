-- 巨蟹座普通形态技能4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984100401 = oo.class(SkillBase)
function Skill984100401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill984100401:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
