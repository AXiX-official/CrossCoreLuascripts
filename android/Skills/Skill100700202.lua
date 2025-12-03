-- 盾击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill100700202 = oo.class(SkillBase)
function Skill100700202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill100700202:DoSkill(caster, target, data)
	-- 100700201
	self.order = self.order + 1
	self:AddBuff(SkillEffect[100700201], caster, target, data, 5001,2)
end
