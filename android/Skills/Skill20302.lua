-- 压制II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill20302 = oo.class(SkillBase)
function Skill20302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill20302:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8091
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.6) then
	else
		return
	end
	-- 20302
	self:AddTempAttr(SkillEffect[20302], caster, self.card, data, "damage",0.24)
end
-- 行动开始
function Skill20302:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8091
	if SkillJudger:TargetPercentHp(self, caster, target, true,0.6) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 203010
	self:ShowTips(SkillEffect[203010], caster, self.card, data, 2,"征服",true)
end
