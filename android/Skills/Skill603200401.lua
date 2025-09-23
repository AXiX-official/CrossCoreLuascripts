-- 形态切换
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603200401 = oo.class(SkillBase)
function Skill603200401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603200401:DoSkill(caster, target, data)
	-- 90012
	self.order = self.order + 1
	self:Transform(SkillEffect[90012], caster, target, data, {progress=1010})
end
