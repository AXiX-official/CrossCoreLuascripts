-- 召喚
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill914200401 = oo.class(SkillBase)
function Skill914200401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill914200401:CanSummon()
	return self.card:CanSummon(10000305,3,{1,3},{progress=105},nil,nil)
end
function Skill914200401:CanSummon()
	return self.card:CanSummon(10000304,3,{1,1},{progress=100},nil,nil)
end
-- 执行技能
function Skill914200401:DoSkill(caster, target, data)
	-- 914200401
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[914200401], caster, self.card, data, 10000304,3,{1,1},{progress=100},nil,nil)
	-- 914200402
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[914200402], caster, self.card, data, 10000305,3,{1,3},{progress=105},nil,nil)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 922800101
	self.order = self.order + 1
	self:AddBuff(SkillEffect[922800101], caster, self.card, data, 922800101)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 922800201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[922800201], caster, self.card, data, 922800201)
end
