-- 洛贝拉2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill338304 = oo.class(SkillBase)
function Skill338304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill338304:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 338304
	self:AddSp(SkillEffect[338304], caster, self.card, data, 25)
end
-- 特殊入场时(复活，召唤，合体)
function Skill338304:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 338314
	self:AddSp(SkillEffect[338314], caster, caster, data, 25)
end
-- 行动结束
function Skill338304:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 338323
	self:AddSp(SkillEffect[338323], caster, self.card, data, 15)
end
