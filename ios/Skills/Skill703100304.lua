-- 子弹风暴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill703100304 = oo.class(SkillBase)
function Skill703100304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill703100304:DoSkill(caster, target, data)
	-- 12007
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12007], caster, target, data, 0.143,7)
end
