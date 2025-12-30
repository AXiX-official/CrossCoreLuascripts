-- 瑞泽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4100705 = oo.class(SkillBase)
function Skill4100705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4100705:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4100705
	self:AddBuffCount(SkillEffect[4100705], caster, self.card, data, 100700101,3,8)
end
