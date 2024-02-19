-- 黑白帽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4304315 = oo.class(SkillBase)
function Skill4304315:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 解体时
function Skill4304315:OnResolve(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304315
	self:CallSkill(SkillEffect[4304315], caster, self.card, data, 304310405)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4304315:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4304316
	self:AddBuff(SkillEffect[4304316], caster, self.card, data, 6209)
end
