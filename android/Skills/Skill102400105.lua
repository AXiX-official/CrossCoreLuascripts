-- 挺进冲拳
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102400105 = oo.class(SkillBase)
function Skill102400105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102400105:DoSkill(caster, target, data)
	-- 11001
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11001], caster, target, data, 1,1)
end
