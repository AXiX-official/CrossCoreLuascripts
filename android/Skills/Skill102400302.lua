-- 阵地构造
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102400302 = oo.class(SkillBase)
function Skill102400302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102400302:DoSkill(caster, target, data)
	-- 102400302
	self.order = self.order + 1
	self:AddBuff(SkillEffect[102400302], caster, target, data, 2162,3)
end
