-- 岁稔4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill335605 = oo.class(SkillBase)
function Skill335605:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill335605:OnBefourCritHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 335605
	self:AddTempAttr(SkillEffect[335605], caster, caster, data, "crit",-0.15)
end