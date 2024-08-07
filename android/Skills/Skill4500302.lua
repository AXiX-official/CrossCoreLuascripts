-- 协调感应
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4500302 = oo.class(SkillBase)
function Skill4500302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4500302:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4500301
	self:AddNp(SkillEffect[4500301], caster, self.card, data, 5)
	-- 4500308
	self:ShowTips(SkillEffect[4500308], caster, self.card, data, 2,"协调感应",true,4500308)
end
-- 回合开始时
function Skill4500302:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4500305
	if self:Rand(4000) then
		self:DelBufferGroup(SkillEffect[4500305], caster, self.card, data, 1,1)
	end
end
