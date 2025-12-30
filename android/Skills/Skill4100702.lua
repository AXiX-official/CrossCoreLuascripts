-- 瑞泽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4100702 = oo.class(SkillBase)
function Skill4100702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4100702:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4100702
	self:AddBuffCount(SkillEffect[4100702], caster, self.card, data, 100700101,1,8)
end
