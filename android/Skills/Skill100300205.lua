-- 援护射击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100300205 = oo.class(SkillBase)
function Skill100300205:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100300205:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
end
-- 行动结束
function Skill100300205:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 100300205
	self:AddBuff(SkillEffect[100300205], caster, self.card, data, 2515)
end
