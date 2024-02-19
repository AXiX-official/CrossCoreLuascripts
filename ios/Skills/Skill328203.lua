-- 巴德兰兹天赋2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill328203 = oo.class(SkillBase)
function Skill328203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill328203:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 328203
	if self:Rand(4500) then
		self:AddProgress(SkillEffect[328203], caster, self.card, data, 200)
	end
end
