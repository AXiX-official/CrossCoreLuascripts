-- 驱散特性
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4901602 = oo.class(SkillBase)
function Skill4901602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4901602:OnAttackOver(caster, target, data)
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
	-- 4901602
	if self:Rand(4000) then
		self:DelBuffQuality(SkillEffect[4901602], caster, target, data, 2,2)
	end
end
