-- 防护I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010130 = oo.class(SkillBase)
function Skill1100010130:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100010130:OnBorn(caster, target, data)
	-- 1100010130
	if SkillJudger:AddBuff(self, caster, self.card, 1100010130) then
		-- 2201
		local targets = SkillFilter:All(self, caster, target, 1)
		for i,target in ipairs(targets) do
			self:AddBuff(SkillEffect[2201], caster, target, data, 2101)
		end
	end
end
