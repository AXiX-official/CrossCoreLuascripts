-- 能伤II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010211 = oo.class(SkillBase)
function Skill1100010211:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100010211:OnBefourHurt(caster, target, data)
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
	-- 8223
	if SkillJudger:IsDamageType(self, caster, target, true,2) then
	else
		return
	end
	-- 1100010211
	self:AddTempAttr(SkillEffect[1100010211], caster, self.card, data, "damage",0.20)
end
