-- 鸣刃2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334903 = oo.class(SkillBase)
function Skill334903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill334903:OnActionOver2(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 334903
	if self:Rand(6000) then
		self:Help(SkillEffect[334903], caster, target, data, 2)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill334903:OnBornSpecial(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 334912
	self:OwnerAddBuffCount(SkillEffect[334912], caster, self.card, data, 704100101,2,6)
end
