-- 求生II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23202 = oo.class(SkillBase)
function Skill23202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill23202:OnAfterHurt(caster, target, data)
	-- 8344
	local sign4 = SkillApi:GetValue(self, caster, self.card,3,"sign4")
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 23202
	self:AddBuff(SkillEffect[23202], caster, self.card, data, 23202)
end
-- 治疗时
function Skill23202:OnCure(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 23212
	self:AddBuff(SkillEffect[23212], caster, self.card, data, 23202)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8148
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.8) then
	else
		return
	end
	-- 232010
	self:ShowTips(SkillEffect[232010], caster, self.card, data, 2,"复苏",true,232010)
end
