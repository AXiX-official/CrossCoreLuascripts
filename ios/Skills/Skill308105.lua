-- 天赋效果308105
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill308105 = oo.class(SkillBase)
function Skill308105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill308105:OnCure(caster, target, data)
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
	-- 308105
	if self:Rand(6000) then
		self:DelBufferGroup(SkillEffect[308105], caster, self.card, data, 3,1)
	end
end
