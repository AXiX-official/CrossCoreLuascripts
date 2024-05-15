-- 求生I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23201 = oo.class(SkillBase)
function Skill23201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill23201:OnAfterHurt(caster, target, data)
	-- 8344
	local sign4 = SkillApi:GetValue(self, caster, self.card,3,"sign4")
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 23201
	self:AddBuff(SkillEffect[23201], caster, self.card, data, 23201)
end
-- 治疗时
function Skill23201:OnCure(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 23211
	self:AddBuff(SkillEffect[23211], caster, self.card, data, 23201)
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
