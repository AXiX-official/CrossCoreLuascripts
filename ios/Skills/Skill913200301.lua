-- 第四章天使 3技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913200301 = oo.class(SkillBase)
function Skill913200301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill913200301:CanSummon()
	return self.card:CanSummon(10000209,3,{1,3},{progress=300},nil,nil)
end
function Skill913200301:CanSummon()
	return self.card:CanSummon(10000208,3,{1,2},{progress=400},nil,nil)
end
function Skill913200301:CanSummon()
	return self.card:CanSummon(10000207,3,{1,1},{progress=500},nil,nil)
end
-- 执行技能
function Skill913200301:DoSkill(caster, target, data)
	-- 913200302
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913200302], caster, target, data, 10000207,3,{1,1},{progress=500},nil,nil)
	-- 913200303
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913200303], caster, target, data, 10000208,3,{1,2},{progress=400},nil,nil)
	-- 913200304
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[913200304], caster, target, data, 10000209,3,{1,3},{progress=300},nil,nil)
end
-- 行动结束
function Skill913200301:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 913200301
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[913200301], caster, target, data, 913200301)
	end
end
