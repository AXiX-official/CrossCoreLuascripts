-- 晶之盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4601102 = oo.class(SkillBase)
function Skill4601102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4601102:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 4601102
	self:AddBuff(SkillEffect[4601102], caster, self.card, data, 2407)
	-- 4601106
	self:ShowTips(SkillEffect[4601106], caster, self.card, data, 2,"攻防一体",true)
end
