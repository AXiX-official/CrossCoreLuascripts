-- 折光之钥
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983630201 = oo.class(SkillBase)
function Skill983630201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill983630201:DoSkill(caster, target, data)
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
	-- 983630202
	self.order = self.order + 1
	self:AddBuff(SkillEffect[983630202], caster, self.card, data, 983610202,1)
	-- 983630203
	self.order = self.order + 1
	self:ChangeSkill(SkillEffect[983630203], caster, self.card, data, 2,983630401)
end
