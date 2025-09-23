-- 洛贝拉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603300203 = oo.class(SkillBase)
function Skill603300203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603300203:DoSkill(caster, target, data)
	-- 4005
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4005], caster, target, data, 4005)
end
