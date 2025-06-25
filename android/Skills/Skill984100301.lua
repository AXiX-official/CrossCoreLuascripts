-- 离魂者技能3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984100301 = oo.class(SkillBase)
function Skill984100301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill984100301:CanSummon()
	return self.card:CanSummon(1095014,3,{1,3},{progress=1200},nil,nil)
end
function Skill984100301:CanSummon()
	return self.card:CanSummon(1095013,3,{1,2},{progress=1000},nil,nil)
end
function Skill984100301:CanSummon()
	return self.card:CanSummon(1095012,3,{1,1},{progress=500},nil,nil)
end
-- 执行技能
function Skill984100301:DoSkill(caster, target, data)
	-- 950100301
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[950100301], caster, self.card, data, 1095012,3,{1,1},{progress=500},nil,nil)
	-- 950100302
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[950100302], caster, self.card, data, 1095013,3,{1,2},{progress=1000},nil,nil)
	-- 950100303
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[950100303], caster, self.card, data, 1095014,3,{1,3},{progress=1200},nil,nil)
end
