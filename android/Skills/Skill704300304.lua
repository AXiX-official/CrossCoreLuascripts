-- 岁稔技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704300304 = oo.class(SkillBase)
function Skill704300304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704300304:DoSkill(caster, target, data)
	-- 704300304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704300304], caster, target, data, 704300304)
end
