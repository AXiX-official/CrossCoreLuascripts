-- 抗压III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24703 = oo.class(SkillBase)
function Skill24703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill24703:OnActionOver(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 24703
	self:AddBuff(SkillEffect[24703], caster, self.card, data, 24703)
	-- 247010
	self:ShowTips(SkillEffect[247010], caster, self.card, data, 2,"愤怒",true)
end
