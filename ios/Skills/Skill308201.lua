-- 天赋效果308201
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill308201 = oo.class(SkillBase)
function Skill308201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill308201:OnCure(caster, target, data)
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 308201
	if self:Rand(2000) then
		self:DelBufferGroup(SkillEffect[308201], caster, self.card, data, 3,1)
	end
end
