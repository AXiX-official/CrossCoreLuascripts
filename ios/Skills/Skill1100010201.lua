-- 增加20%造成的物理伤害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010201 = oo.class(SkillBase)
function Skill1100010201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100010201:OnBefourHurt(caster, target, data)
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
	-- 8222
	if SkillJudger:IsDamageType(self, caster, target, true,1) then
	else
		return
	end
	-- 1100010201
	self:AddTempAttr(SkillEffect[1100010201], caster, self.card, data, "damage",0.20)
end
