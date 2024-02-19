-- 天赋效果309801
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill309801 = oo.class(SkillBase)
function Skill309801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill309801:OnActionBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8100
	if SkillJudger:CompareAttr(self, caster, target, true,"speed") then
	else
		return
	end
	-- 309801
	self:AddBuff(SkillEffect[309801], caster, self.card, data, 4502)
end
-- 行动结束
function Skill309801:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8100
	if SkillJudger:CompareAttr(self, caster, target, true,"speed") then
	else
		return
	end
	-- 309811
	self:DelBuff(SkillEffect[309811], caster, self.card, data, 4502,1)
end
