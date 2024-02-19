-- 努特4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill331602 = oo.class(SkillBase)
function Skill331602:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill331602:OnAfterHurt(caster, target, data)
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
	-- 8410
	local count10 = SkillApi:BuffCount(self, caster, target,2,1,3)
	-- 8109
	if SkillJudger:Greater(self, caster, self.card, true,count10,0) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 331602
	if self:Rand(5000) then
		self:LimitDamage(SkillEffect[331602], caster, target, data, 1,0.25)
		-- 92003
		self:DelBufferGroup(SkillEffect[92003], caster, target, data, 3,1)
	end
end
