-- 天赋效果301602
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301602 = oo.class(SkillBase)
function Skill301602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill301602:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 301602
	if self:Rand(2000) then
		self:BeatBack(SkillEffect[301602], caster, target, data, nil)
	end
end
