-- 复苏
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1020109 = oo.class(SkillBase)
function Skill1020109:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1020109:DoSkill(caster, target, data)
	-- 1020109
	self.order = self.order + 1
	self:Revive(SkillEffect[1020109], caster, target, data, 2,0.36,{progress=700})
end
