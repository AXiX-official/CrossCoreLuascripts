-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill50010101 = oo.class(SkillBase)
function Skill50010101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill50010101:DoSkill(caster, target, data)
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
	self.order = self.order + 1
	self:AddSp(SkillEffect[80002], caster, caster, data, 15)
end
