-- 伊根3（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill603501303 = oo.class(SkillBase)
function Skill603501303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill603501303:DoSkill(caster, target, data)
	-- 12006
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12006], caster, target, data, 0.167,6)
end
