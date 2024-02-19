-- 拉被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4703606 = oo.class(SkillBase)
function Skill4703606:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4703606:OnAttackOver(caster, target, data)
	-- 4703606
	self:CallSkill(SkillEffect[4703606], caster, self.card, data, 703600401)
end
