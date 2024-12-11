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
	self:AddBuffCount(SkillEffect[980100601], caster, self.card, data, 980100601,30,30)
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
	self:AddBuffCount(SkillEffect[980100602], caster, self.card, data, 980100601,-1,30)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 980100604
	self:AddBuffCount(SkillEffect[980100604], caster, self.card, data, 980100603,1,30)
end
-- 攻击结束
function Skill980100601:OnAttackOver(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 980100605
	self:OwnerAddBuffCount(SkillEffect[980100605], caster, self.card, data, 980100601,-1,30)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 980100606
	self:OwnerAddBuffCount(SkillEffect[980100606], caster, self.card, data, 980100603,1,30)
end
