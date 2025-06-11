-- 提泽纳特性被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913800401 = oo.class(SkillBase)
function Skill913800401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill913800401:OnAttackOver(caster, target, data)
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
	-- 913800405
	self:tFunc_913800405_913800402(caster, target, data)
	self:tFunc_913800405_913800403(caster, target, data)
end
-- 入场时
function Skill913800401:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913800401
	self:AddBuff(SkillEffect[913800401], caster, self.card, data, 4212)
end
function Skill913800401:tFunc_913800405_913800402(caster, target, data)
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
	-- 913800402
	self:OwnerAddBuffCount(SkillEffect[913800402], caster, self.card, data, 913800501,-1,40)
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
	-- 913800404
	self:OwnerAddBuffCount(SkillEffect[913800404], caster, caster, data, 913800501,1,40)
end
function Skill913800401:tFunc_913800405_913800403(caster, target, data)
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
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 913800403
	self:OwnerAddBuffCount(SkillEffect[913800403], caster, self.card, data, 913800501,-1,40)
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
	-- 913800404
	self:OwnerAddBuffCount(SkillEffect[913800404], caster, caster, data, 913800501,1,40)
end
