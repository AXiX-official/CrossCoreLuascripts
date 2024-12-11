-- 暴虐山脉被动4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980101101 = oo.class(SkillBase)
function Skill980101101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill980101101:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980101101
	local targets = SkillFilter:Group(self, caster, target, 4,1)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[980101101], caster, target, data, 980101101)
	end
end
-- 伤害前
function Skill980101101:OnBefourHurt(caster, target, data)
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
	-- 9727
	local count816 = SkillApi:GetAttr(self, caster, target,1,"defense")
	-- 9713
	local count802 = SkillApi:ClassCount(self, caster, target,1,1)
	-- 8229
	if SkillJudger:IsCasterMech(self, caster, self.card, true,1) then
	else
		return
	end
	-- 980101102
	self:AddHp(SkillEffect[980101102], caster, target, data, -1*count816*count802)
end
