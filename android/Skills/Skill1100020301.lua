-- 角色暴击伤害提高20%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020301 = oo.class(SkillBase)
function Skill1100020301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100020301:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100020301
	self:AddBuff(SkillEffect[1100020301], caster, self.card, data, 1100020301)
end