-- 肉鸽不朽阵营不再过热（金色1级别）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100030030 = oo.class(SkillBase)
function Skill1100030030:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100030030:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 1100030013
	self:AddHp(SkillEffect[1100030013], caster, caster, data, -count20*0.4)
end
