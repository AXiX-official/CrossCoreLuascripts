-- 薄暮西沉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4703102 = oo.class(SkillBase)
function Skill4703102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4703102:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703102
	self:OwnerAddBuffCount(SkillEffect[4703102], caster, self.card, data, 4703102,1,3)
end
