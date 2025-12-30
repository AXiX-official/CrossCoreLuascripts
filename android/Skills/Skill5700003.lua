-- 怪物群攻模组技能buff1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5700003 = oo.class(SkillBase)
function Skill5700003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill5700003:CanSummon()
	return self.card:CanSummon(160105518,3,{2,1},{progress=1000},nil,nil)
end
-- 死亡时
function Skill5700003:OnDeath(caster, target, data)
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
	-- 5700007
	if SkillJudger:HasBuff(self, caster, target, true,2,5700006) then
	else
		return
	end
	-- 5700004
	self:SummonTeammate(SkillEffect[5700004], caster, self.card, data, 160105518,3,{2,1},{progress=1000},nil,nil)
end
