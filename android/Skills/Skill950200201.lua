-- 防御状态
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill950200201 = oo.class(SkillBase)
function Skill950200201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill950200201:DoSkill(caster, target, data)
	-- 6110
	self.order = self.order + 1
	self:AddBuff(SkillEffect[6110], caster, self.card, data, 6103,1)
end
