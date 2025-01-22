-- 岁稔技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704300303 = oo.class(SkillBase)
function Skill704300303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704300303:DoSkill(caster, target, data)
	-- 704300303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704300303], caster, target, data, 704300303)
end
