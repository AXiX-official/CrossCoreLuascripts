-- 迅捷II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill21502 = oo.class(SkillBase)
function Skill21502:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill21502:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 21502
	if self:Rand(3500) then
		self:AddProgress(SkillEffect[21502], caster, self.card, data, 400)
		-- 215010
		self:ShowTips(SkillEffect[215010], caster, self.card, data, 2,"灵巧",true)
	end
end
