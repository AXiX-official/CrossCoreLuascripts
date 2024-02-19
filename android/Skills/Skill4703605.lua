-- 拉被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4703605 = oo.class(SkillBase)
function Skill4703605:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4703605:OnAttackOver(caster, target, data)
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
	-- 4703605
	if self:Rand(5000) then
		self:AddNp(SkillEffect[4703605], caster, self.card, data, 20)
		-- 4703608
		self:CallSkill(SkillEffect[4703608], caster, self.card, data, 703600403)
	end
end
