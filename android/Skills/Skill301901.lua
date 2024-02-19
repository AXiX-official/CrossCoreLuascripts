-- 转速耦合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301901 = oo.class(SkillBase)
function Skill301901:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill301901:OnDeath(caster, target, data)
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
	-- 301901
	self:AddNp(SkillEffect[301901], caster, self.card, data, 4)
end
