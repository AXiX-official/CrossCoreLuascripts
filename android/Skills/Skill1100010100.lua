-- 击杀目标时永久增加20%攻击力
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010100 = oo.class(SkillBase)
function Skill1100010100:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill1100010100:OnDeath(caster, target, data)
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
	-- 1100010100
	self:AddBuff(SkillEffect[1100010100], caster, self.card, data, 1100010100)
end