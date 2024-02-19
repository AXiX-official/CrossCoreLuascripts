-- 预热
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980100601 = oo.class(SkillBase)
function Skill980100601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill980100601:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980100601
	self:AddBuffCount(SkillEffect[980100601], caster, self.card, data, 980100601,5,5)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980100603
	self:AddBuff(SkillEffect[980100603], caster, self.card, data, 980100602)
end
-- 回合结束时
function Skill980100601:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980100602
	self:AddBuffCount(SkillEffect[980100602], caster, self.card, data, 980100601,-1,5)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980100604
	self:AddBuffCount(SkillEffect[980100604], caster, self.card, data, 980100603,1,5)
end
