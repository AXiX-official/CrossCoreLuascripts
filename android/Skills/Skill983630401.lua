-- 双子宫
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill983630401 = oo.class(SkillBase)
function Skill983630401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill983630401:DoSkill(caster, target, data)
	-- 200900301
	self.order = self.order + 1
	self:Cure(SkillEffect[200900301], caster, target, data, 1,0.10)
end
-- 攻击结束
function Skill983630401:OnAttackOver(caster, target, data)
	-- 983630205
	self:ChangeSkill(SkillEffect[983630205], caster, self.card, data, 2,983630201)
end
