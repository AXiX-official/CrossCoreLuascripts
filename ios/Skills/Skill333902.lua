--  赤溟2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill333902 = oo.class(SkillBase)
function Skill333902:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill333902:OnAddBuff(caster, target, data, buffer)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8255
	if SkillJudger:HasBuff(self, caster, target, true,3,1,1) then
	else
		return
	end
	-- 333911
	self:AddBuffCount(SkillEffect[333911], caster, self.card, data, 304900101,1,10)
end
-- 伤害前
function Skill333902:OnBefourHurt(caster, target, data)
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
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 333902
	self:AddTempAttr(SkillEffect[333902], caster, self.card, data, "damage",0.15)
end
