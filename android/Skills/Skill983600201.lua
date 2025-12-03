-- 摩羯座1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983600201 = oo.class(SkillBase)
function Skill983600201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill983600201:CanSummon()
	return self.card:CanSummon(10000302,3,{1,3},{progress=300},nil,nil)
end
function Skill983600201:CanSummon()
	return self.card:CanSummon(10000301,3,{1,2},{progress=200},nil,nil)
end
function Skill983600201:CanSummon()
	return self.card:CanSummon(10000303,3,{1,1},{progress=100},nil,nil)
end
-- 执行技能
function Skill983600201:DoSkill(caster, target, data)
	-- 983600201
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[983600201], caster, self.card, data, 10000303,3,{1,1},{progress=100},nil,nil)
	-- 983600202
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[983600202], caster, self.card, data, 10000301,3,{1,2},{progress=200},nil,nil)
	-- 983600203
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[983600203], caster, self.card, data, 10000302,3,{1,3},{progress=300},nil,nil)
	-- 110008034
	self.order = self.order + 1
	self:AddBuff(SkillEffect[110008034], caster, self.card, data, 983600901)
end
