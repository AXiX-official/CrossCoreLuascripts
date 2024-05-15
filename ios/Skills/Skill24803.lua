-- 顺势III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24803 = oo.class(SkillBase)
function Skill24803:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill24803:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8138
	if SkillJudger:OwnerPercentHp(self, caster, target, true,0.8) then
	else
		return
	end
	-- 24803
	self:AddBuff(SkillEffect[24803], caster, self.card, data, 24803)
	-- 248010
	self:ShowTips(SkillEffect[248010], caster, self.card, data, 2,"自在",true,248010)
end
