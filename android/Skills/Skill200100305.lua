-- 乐驰音掣
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200100305 = oo.class(SkillBase)
function Skill200100305:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200100305:DoSkill(caster, target, data)
	-- 200100305
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200100305], caster, target, data, 200100305)
end