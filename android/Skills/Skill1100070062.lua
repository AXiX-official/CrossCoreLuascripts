-- 击杀敌方有100%概率获得额外回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070062 = oo.class(SkillBase)
function Skill1100070062:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill1100070062:OnDeath(caster, target, data)
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
	-- 1100070062
	if self:Rand(10000) then
		self:ExtraRound(SkillEffect[1100070062], caster, self.card, data, nil)
	end
end