-- 天赋效果64
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8564 = oo.class(SkillBase)
function Skill8564:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill8564:OnCure(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8564
	local r = self.card:Rand(5)+1
	if 1 == r then
		-- 4004
		self:AddBuff(SkillEffect[4004], caster, target, data, 4004)
	elseif 2 == r then
		-- 4104
		self:AddBuff(SkillEffect[4104], caster, target, data, 4104)
	elseif 3 == r then
		-- 4204
		self:AddBuff(SkillEffect[4204], caster, target, data, 4204)
	elseif 4 == r then
		-- 4304
		self:AddBuff(SkillEffect[4304], caster, target, data, 4304)
	elseif 5 == r then
		-- 4701
		self:AddBuff(SkillEffect[4701], caster, target, data, 4701)
	end
end
