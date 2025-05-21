-- OD
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill305001304 = oo.class(SkillBase)
function Skill305001304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill305001304:DoSkill(caster, target, data)
	-- 305000301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[305000301], caster, self.card, data, 305000301)
	-- 305000310
	self.order = self.order + 1
	self:ChangeSkill(SkillEffect[305000310], caster, self.card, data, 3,305000401)
end
