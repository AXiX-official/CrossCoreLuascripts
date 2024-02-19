-- 天赋效果310301
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310301 = oo.class(SkillBase)
function Skill310301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310301:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8208
	if SkillJudger:IsCtrlType(self, caster, target, true,5) then
	else
		return
	end
	-- 310301
	self:AddBuff(SkillEffect[310301], caster, self.card, data, 4502)
end
-- 行动结束
function Skill310301:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8208
	if SkillJudger:IsCtrlType(self, caster, target, true,5) then
	else
		return
	end
	-- 310311
	self:DelBuff(SkillEffect[310311], caster, self.card, data, 4502,1)
end
