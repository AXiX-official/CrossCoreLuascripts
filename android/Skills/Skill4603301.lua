-- 洛贝拉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4603301 = oo.class(SkillBase)
function Skill4603301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill4603301:OnActionBegin(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 603300301
	self:OwnerAddBuffCount(SkillEffect[603300301], caster, self.card, data, 603300301,1,3)
end
-- 伤害前
function Skill4603301:OnBefourHurt(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4603311
	self:LimitDamage(SkillEffect[4603311], caster, target, data, 0.03,2,1)
end
