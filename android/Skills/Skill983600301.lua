-- 摩羯座1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983600301 = oo.class(SkillBase)
function Skill983600301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill983600301:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 983600302
	self.order = self.order + 1
	self:AddBuff(SkillEffect[983600302], caster, target, data, 983600301,1)
end
