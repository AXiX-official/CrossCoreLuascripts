-- 补给能源
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1000302 = oo.class(SkillBase)
function Skill1000302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill1000302:DoSkill(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 1000302
	self.order = self.order + 1
	self:AddNp(SkillEffect[1000302], caster, self.card, data, 10)
end
