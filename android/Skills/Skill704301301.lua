-- 岁稔技能3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704301301 = oo.class(SkillBase)
function Skill704301301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704301301:DoSkill(caster, target, data)
	-- 704301301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704301301], caster, target, data, 704301301)
end
