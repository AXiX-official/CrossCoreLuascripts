-- 受到攻击后叠加攻击力3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010052 = oo.class(SkillBase)
function Skill1100010052:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill1100010052:OnActionOver(caster, target, data)
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
	-- 8449
	local count49 = SkillApi:GetAttr(self, caster, target,3,"maxhp")
	-- 1100010052
	self:AddTempAttr(SkillEffect[1100010052], caster, self.card, data, 1100010050,1,3)
end
