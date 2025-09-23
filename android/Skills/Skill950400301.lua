-- 双子座技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill950400301 = oo.class(SkillBase)
function Skill950400301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill950400301:DoSkill(caster, target, data)
	-- 4101
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4101], caster, target, data, 4101)
end
