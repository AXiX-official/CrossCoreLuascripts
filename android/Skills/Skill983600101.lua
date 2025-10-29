-- 摩羯座1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983600101 = oo.class(SkillBase)
function Skill983600101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill983600101:DoSkill(caster, target, data)
	-- 92003
	self.order = self.order + 1
	self:DelBufferGroup(SkillEffect[92003], caster, target, data, 3,1)
end
