-- 岁稔技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill942300202 = oo.class(SkillBase)
function Skill942300202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill942300202:DoSkill(caster, target, data)
	-- 704300202
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704300202], caster, target, data, 704300202)
end
