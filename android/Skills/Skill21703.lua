-- 斩杀III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill21703 = oo.class(SkillBase)
function Skill21703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill21703:OnBefourHurt(caster, target, data)
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
	-- 8098
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.4) then
	else
		return
	end
	-- 21703
	self:AddTempAttr(SkillEffect[21703], caster, self.card, data, "damage",0.6)
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
	-- 8098
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.4) then
	else
		return
	end
	-- 217010
	self:ShowTips(SkillEffect[217010], caster, self.card, data, 2,"致命",true,217010)
end
