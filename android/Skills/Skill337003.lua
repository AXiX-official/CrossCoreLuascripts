-- 提泽纳4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill337003 = oo.class(SkillBase)
function Skill337003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill337003:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 337003
	self:AddSp(SkillEffect[337003], caster, self.card, data, 20)
end
-- 特殊入场时(复活，召唤，合体)
function Skill337003:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 337013
	self:AddSp(SkillEffect[337013], caster, caster, data, 20)
	-- 337023
	self:AddBuff(SkillEffect[337023], caster, self.card, data, 337003)
end
-- 死亡时
function Skill337003:OnDeath(caster, target, data)
	-- 8074
	if SkillJudger:TargetIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 337026
	self:DelBufferTypeForce(SkillEffect[337026], caster, self.card, data, 337001)
end
