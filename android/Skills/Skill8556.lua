-- 天赋效果56
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8556 = oo.class(SkillBase)
function Skill8556:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8556:OnAttackOver(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8442
	local count42 = SkillApi:SkillLevel(self, caster, target,3,3123)
	-- 8556
	self:AddBuff(SkillEffect[8556], caster, self.card, data, 6500+count42)
end
