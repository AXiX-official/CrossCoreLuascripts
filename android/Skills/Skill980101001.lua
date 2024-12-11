-- 引力神光（驱散）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980101001 = oo.class(SkillBase)
function Skill980101001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill980101001:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 攻击结束
function Skill980101001:OnAttackOver(caster, target, data)
	-- 980101001
	self:DelBufferGroup(SkillEffect[980101001], caster, target, data, 2,2)
end
