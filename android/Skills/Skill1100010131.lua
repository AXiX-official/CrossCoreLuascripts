-- 防护II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010131 = oo.class(SkillBase)
function Skill1100010131:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100010131:OnBorn(caster, target, data)
	-- 1100010131
	if SkillJudger:AddBuff(self, caster, self.card, 1100010131) then
		-- 2202
		local targets = SkillFilter:All(self, caster, target, 1)
		for i,target in ipairs(targets) do
			self:AddBuff(SkillEffect[2202], caster, target, data, 2109)
		end
	end
end
