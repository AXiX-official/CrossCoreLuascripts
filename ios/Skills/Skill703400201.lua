-- 全体戒备
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703400201 = oo.class(SkillBase)
function Skill703400201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703400201:DoSkill(caster, target, data)
	-- 703400201
	self.order = self.order + 1
	self:Cure(SkillEffect[703400201], caster, target, data, 1,0.06)
	-- 703400211
	self.order = self.order + 1
	self:AddBuff(SkillEffect[703400211], caster, target, data, 703400201,2)
end
