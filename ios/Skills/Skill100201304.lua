-- 绝对壁垒（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100201304 = oo.class(SkillBase)
function Skill100201304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100201304:DoSkill(caster, target, data)
	-- 100201304
	self.order = self.order + 1
	self:AddBuff(SkillEffect[100201304], caster, target, data, 4607,4)
	-- 100201307
	self.order = self.order + 1
	self:OwnerAddBuffCount(SkillEffect[100201307], caster, target, data, 3404,2,2)
	-- 92013
	self.order = self.order + 1
	self:DelBuffQuality(SkillEffect[92013], caster, target, data, 2,2)
end
