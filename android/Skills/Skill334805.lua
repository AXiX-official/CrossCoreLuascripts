-- 艾穆尔4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334805 = oo.class(SkillBase)
function Skill334805:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill334805:OnActionBegin(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 330205
	self:OwnerAddBuff(SkillEffect[330205], caster, caster, data, 330205,1)
end
-- 行动结束2
function Skill334805:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 331206
	self:AddSp(SkillEffect[331206], caster, self.card, data, 15)
end
-- 行动结束
function Skill334805:OnActionOver(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 331207
	self:AddSp(SkillEffect[331207], caster, caster, data, 15)
end