-- 天赋效果304403
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill304403 = oo.class(SkillBase)
function Skill304403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill304403:OnAfterHurt(caster, target, data)
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
	-- 304403
	self:HitAddBuff(SkillEffect[304403], caster, target, data, 1600,1001)
end
