-- 技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302500302 = oo.class(SkillBase)
function Skill302500302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill302500302:DoSkill(caster, target, data)
	-- 12004
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12004], caster, target, data, 0.25,4)
end
