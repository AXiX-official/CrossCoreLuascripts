-- 世界boss词条buff3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill5800003 = oo.class(SkillBase)
function Skill5800003:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill5800003:OnBefourHurt(caster, target, data)
	-- 5800008
	self:tFunc_5800008_5800006(caster, target, data)
	self:tFunc_5800008_5800007(caster, target, data)
end
function Skill5800003:tFunc_5800008_5800007(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 5800007
	self:AddTempAttr(SkillEffect[5800007], caster, self.card, data, "damage",-0.3)
end
function Skill5800003:tFunc_5800008_5800006(caster, target, data)
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
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 5800006
	self:AddTempAttr(SkillEffect[5800006], caster, self.card, data, "damage",1.5)
end
