-- 差速冲击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill401900301 = oo.class(SkillBase)
function Skill401900301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill401900301:DoSkill(caster, target, data)
	-- 12001
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12001], caster, target, data, 1,1)
	-- 5204
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[5204], caster, target, data, 10000,5204)
end
