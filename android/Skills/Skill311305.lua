-- 吸收盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill311305 = oo.class(SkillBase)
function Skill311305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill311305:OnActionOver(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 311305
	self:AddBuff(SkillEffect[311305], caster, self.card, data, 2406)
end
