-- 暴伤后20%几率使目标行动推后20%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010291 = oo.class(SkillBase)
function Skill1100010291:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill1100010291:OnAfterHurt(caster, target, data)
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
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 1100010291
	if self:Rand(2000) then
		self:AddProgress(SkillEffect[1100010291], caster, target, data, -200)
	end
end
