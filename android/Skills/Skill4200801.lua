-- 微观
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4200801 = oo.class(SkillBase)
function Skill4200801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill4200801:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4200801
	if self:Rand(2000) then
		self:AddProgress(SkillEffect[4200801], caster, self.card, data, 300)
		-- 4200806
		self:ShowTips(SkillEffect[4200806], caster, self.card, data, 2,"微观",true)
	end
end
