-- 多队战斗反击流关卡1buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070201 = oo.class(SkillBase)
function Skill1100070201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100070201:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 1100071201
	self:AddTempAttr(SkillEffect[1100071201], caster, self.card, data, "bedamage",0.1)
end
