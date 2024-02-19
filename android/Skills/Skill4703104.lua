-- 薄暮西沉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4703104 = oo.class(SkillBase)
function Skill4703104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4703104:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703104
	self:OwnerAddBuffCount(SkillEffect[4703104], caster, self.card, data, 4703103,1,4)
end
