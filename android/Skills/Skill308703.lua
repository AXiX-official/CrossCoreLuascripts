-- 天赋效果308703
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill308703 = oo.class(SkillBase)
function Skill308703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill308703:OnBefourHurt(caster, target, data)
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
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 308703
	self:AddBuff(SkillEffect[308703], caster, target, data, 5003,1)
end
