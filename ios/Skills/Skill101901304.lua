-- 嘲讽挑衅（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill101901304 = oo.class(SkillBase)
function Skill101901304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill101901304:DoSkill(caster, target, data)
	-- 101901304
	self.order = self.order + 1
	self:HitAddBuff(SkillEffect[101901304], caster, target, data, 10000,3001,2)
end
