-- 奏响战歌
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200200301 = oo.class(SkillBase)
function Skill200200301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200200301:DoSkill(caster, target, data)
	-- 200200301
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200301], caster, target, data, 200200301)
	-- 200200311
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200311], caster, target, data, 200200311)
end
