-- 吸收护盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill901700301 = oo.class(SkillBase)
function Skill901700301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill901700301:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 901700301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[901700301], caster, target, data, 2152)
end
