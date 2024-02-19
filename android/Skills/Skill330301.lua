-- 阿图姆天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill330301 = oo.class(SkillBase)
function Skill330301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill330301:OnDeath(caster, target, data)
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
	-- 330301
	self:AddProgress(SkillEffect[330301], caster, self.card, data, 100)
end
