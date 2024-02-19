-- 所向披靡
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill317204 = oo.class(SkillBase)
function Skill317204:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill317204:OnDeath(caster, target, data)
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
	-- 317211
	self:AddValue(SkillEffect[317211], caster, self.card, data, "jishashu",1,0,5)
end
-- 伤害前
function Skill317204:OnBefourHurt(caster, target, data)
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
	-- 317212
	local jishashu = SkillApi:GetValue(self, caster, target,1,"jishashu")
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 317204
	self:AddTempAttr(SkillEffect[317204], caster, self.card, data, "damage",jishashu*0.08)
end
