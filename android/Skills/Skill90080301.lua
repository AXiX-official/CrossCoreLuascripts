-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill90080301 = oo.class(SkillBase)
function Skill90080301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill90080301:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12003], caster, target, data, 0.33,3)
end
