-- 火力全开
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1030204 = oo.class(SkillBase)
function Skill1030204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1030204:DoSkill(caster, target, data)
	-- 1030204
	self.order = self.order + 1
	self:AddBuff(SkillEffect[1030204], caster, target, data, 1030204)
end
