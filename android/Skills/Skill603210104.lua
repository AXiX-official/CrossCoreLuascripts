-- 赫格尼技能1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603210104 = oo.class(SkillBase)
function Skill603210104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603210104:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
end
-- 行动结束2
function Skill603210104:OnActionOver2(caster, target, data)
	-- 603210101
	self:OwnerAddBuffCount(SkillEffect[603210101], caster, self.card, data, 4603201,-2,10)
	-- 603210102
	self:OwnerAddBuffCount(SkillEffect[603210102], caster, self.card, data, 4603211,2,999)
end
