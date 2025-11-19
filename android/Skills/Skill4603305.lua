-- 洛贝拉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4603305 = oo.class(SkillBase)
function Skill4603305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill4603305:OnActionBegin(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 603300303
	self:OwnerAddBuffCount(SkillEffect[603300303], caster, self.card, data, 603300301,1,5)
	-- 9731
	if SkillJudger:IsTypeOf(self, caster, target, true,4) then
	else
		return
	end
	-- 603300304
	self:OwnerAddBuffCount(SkillEffect[603300304], caster, self.card, data, 603300301,1,5)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4603305:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 4603303
	self:OwnerAddBuffCount(SkillEffect[4603303], caster, self.card, data, 603300301,1,5)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 4603301
	self:AddOwnerEquipSkill(SkillEffect[4603301], caster, caster, data, nil)
end
-- 行动结束
function Skill4603305:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 4603304
	self:OwnerAddBuffCount(SkillEffect[4603304], caster, self.card, data, 603300301,1,5)
end
-- 伤害前
function Skill4603305:OnBefourHurt(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4603313
	self:LimitDamage(SkillEffect[4603313], caster, target, data, 0.04,3,1)
end
