-- 能量迸射
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill701300101 = oo.class(SkillBase)
function Skill701300101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill701300101:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
	-- 5104
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[5104], caster, target, data, 10000,5104)
end
