-- 扩散爆炸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4402202 = oo.class(SkillBase)
function Skill4402202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill4402202:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4402202
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4402202], caster, target, data, 1033)
	end
end
-- 入场时
function Skill4402202:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4402206
	self:AddBuff(SkillEffect[4402206], caster, self.card, data, 1031)
end
