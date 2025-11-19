-- 洛贝拉4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338404 = oo.class(SkillBase)
function Skill338404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill338404:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 338404
	self:AddBuff(SkillEffect[338404], caster, self.card, data, 338404)
	-- 338414
	self:AddBuff(SkillEffect[338414], caster, caster, data, 338404)
end
