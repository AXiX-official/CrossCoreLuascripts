-- 奏响战歌
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill200200303 = oo.class(SkillBase)
function Skill200200303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill200200303:DoSkill(caster, target, data)
	-- 200200303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200303], caster, target, data, 200200303)
	-- 200200313
	self.order = self.order + 1
	self:AddBuff(SkillEffect[200200313], caster, target, data, 200200313)
end
