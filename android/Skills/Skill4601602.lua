-- 艾穆尔
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4601602 = oo.class(SkillBase)
function Skill4601602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4601602:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4601602
	local targets = SkillFilter:Group(self, caster, target, 3,6)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4601602], caster, target, data, 4601602)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill4601602:OnBornSpecial(caster, target, data)
	-- 8239
	if SkillJudger:IsCasterMech(self, caster, self.card, true,6) then
	else
		return
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4601612
	self:AddBuff(SkillEffect[4601612], caster, caster, data, 4601602)
end
