-- 天赋效果301105
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill301105 = oo.class(SkillBase)
function Skill301105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill301105:OnBefourHurt(caster, target, data)
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
	-- 8412
	local count12 = SkillApi:BuffCount(self, caster, target,2,1,2)
	-- 301105
	self:AddTempAttr(SkillEffect[301105], caster, self.card, data, "damage",count12*0.12)
end
