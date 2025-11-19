-- 洛贝拉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4603304 = oo.class(SkillBase)
function Skill4603304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill4603304:OnActionBegin(caster, target, data)
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
	-- 603300302
	self:OwnerAddBuffCount(SkillEffect[603300302], caster, self.card, data, 603300301,1,4)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4603304:OnBornSpecial(caster, target, data)
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
-- 伤害前
function Skill4603304:OnBefourHurt(caster, target, data)
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
