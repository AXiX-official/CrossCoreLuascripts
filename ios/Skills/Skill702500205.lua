-- 霜寒守护
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill702500205 = oo.class(SkillBase)
function Skill702500205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill702500205:DoSkill(caster, target, data)
	-- 702400205
	self.order = self.order + 1
	self:AddBuff(SkillEffect[702400205], caster, target, data, 702400205,2)
end
