-- 巨蟹座普通形态技能4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984110401 = oo.class(SkillBase)
function Skill984110401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill984110401:DoSkill(caster, target, data)
	-- 11004
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11004], caster, target, data, 0.25,4)
end
