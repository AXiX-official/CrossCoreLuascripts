-- 卡提那·联域3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780200303 = oo.class(SkillBase)
function Skill780200303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780200303:DoSkill(caster, target, data)
	-- 4404
	self.order = self.order + 1
	self:AddBuff(SkillEffect[4404], caster, target, data, 4404)
end
