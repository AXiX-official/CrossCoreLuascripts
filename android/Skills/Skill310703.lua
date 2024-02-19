-- 天赋效果310703
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310703 = oo.class(SkillBase)
function Skill310703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill310703:OnActionBegin(caster, target, data)
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
	-- 8212
	if SkillJudger:IsCtrlType(self, caster, target, true,9) then
	else
		return
	end
	-- 310703
	self:AddBuff(SkillEffect[310703], caster, self.card, data, 4504)
end
-- 行动结束
function Skill310703:OnActionOver(caster, target, data)
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
	-- 8212
	if SkillJudger:IsCtrlType(self, caster, target, true,9) then
	else
		return
	end
	-- 310713
	self:DelBuff(SkillEffect[310713], caster, self.card, data, 4504,1)
end
