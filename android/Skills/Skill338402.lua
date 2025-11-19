-- 洛贝拉4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338402 = oo.class(SkillBase)
function Skill338402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill338402:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 338402
	self:AddBuff(SkillEffect[338402], caster, self.card, data, 338402)
	-- 338412
	self:AddBuff(SkillEffect[338412], caster, caster, data, 338402)
end
