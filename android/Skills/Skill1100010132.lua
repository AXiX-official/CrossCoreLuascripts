-- 防护III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010132 = oo.class(SkillBase)
function Skill1100010132:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100010132:OnBorn(caster, target, data)
	-- 1100010132
	if SkillJudger:AddBuff(self, caster, self.card, 1100010132) then
		-- 2203
		local targets = SkillFilter:All(self, caster, target, 1)
		for i,target in ipairs(targets) do
			self:AddBuff(SkillEffect[2203], caster, target, data, 2114)
		end
	end
end
