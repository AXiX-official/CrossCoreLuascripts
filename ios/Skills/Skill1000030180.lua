-- 物攻词条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000030180 = oo.class(SkillBase)
function Skill1000030180:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1000030180:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 1000030180
	self:AddBuffCount(SkillEffect[1000030180], caster, self.card, data, 1000030181,1,5)
end
