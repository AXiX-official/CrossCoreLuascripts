-- 蜘蛛1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914300101 = oo.class(SkillBase)
function Skill914300101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill914300101:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
	-- 3004
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[3004], caster, target, data, 10000,3004)
end
