-- 莫拉鲁塔OD
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603001301 = oo.class(SkillBase)
function Skill603001301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603001301:DoSkill(caster, target, data)
	-- 11006
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11006], caster, target, data, 0.167,6)
end
