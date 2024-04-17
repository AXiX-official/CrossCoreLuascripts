-- 赤溟4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334004 = oo.class(SkillBase)
function Skill334004:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill334004:OnCure(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334011
	self:AddBuffCount(SkillEffect[334011], caster, self.card, data, 304900101,1,10)
end
-- 入场时
function Skill334004:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334004
	self:AddBuff(SkillEffect[334004], caster, self.card, data, 334004)
end
