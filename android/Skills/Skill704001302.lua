-- 赤夕技能3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704001302 = oo.class(SkillBase)
function Skill704001302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704001302:DoSkill(caster, target, data)
	-- 704001302
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704001302], caster, target, data, 704001302)
	-- 704001311
	self.order = self.order + 1
	self:Cure(SkillEffect[704001311], caster, target, data, 1,0.2)
end
