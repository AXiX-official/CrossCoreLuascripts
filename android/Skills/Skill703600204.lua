-- 拉技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703600204 = oo.class(SkillBase)
function Skill703600204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703600204:DoSkill(caster, target, data)
	-- 703600204
	self.order = self.order + 1
	self:Revive(SkillEffect[703600204], caster, target, data, 1,0.45,{progress=750})
end
