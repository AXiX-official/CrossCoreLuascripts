-- 冷酷追击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill319102 = oo.class(SkillBase)
function Skill319102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill319102:OnActionOver(caster, target, data)
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 8098
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.4) then
	else
		return
	end
	-- 319102
	self:CallSkill(SkillEffect[319102], caster, self.card, data, 700900201)
end
