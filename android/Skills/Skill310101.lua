-- 天赋效果310101
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310101 = oo.class(SkillBase)
function Skill310101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310101:OnActionBegin(caster, target, data)
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
	-- 8206
	if SkillJudger:IsCtrlType(self, caster, target, true,3) then
	else
		return
	end
	-- 310101
	self:AddBuff(SkillEffect[310101], caster, self.card, data, 4502)
end
-- 行动结束
function Skill310101:OnActionOver(caster, target, data)
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
	-- 8206
	if SkillJudger:IsCtrlType(self, caster, target, true,3) then
	else
		return
	end
	-- 310111
	self:DelBuff(SkillEffect[310111], caster, self.card, data, 4502,1)
end
