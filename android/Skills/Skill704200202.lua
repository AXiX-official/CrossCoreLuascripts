-- 熔铄技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704200202 = oo.class(SkillBase)
function Skill704200202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704200202:DoSkill(caster, target, data)
	-- 704200202
	self.order = self.order + 1
	self:AddBuff(SkillEffect[704200202], caster, target, data, 704200202)
end