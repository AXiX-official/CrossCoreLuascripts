-- 曙暮辉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4400605 = oo.class(SkillBase)
function Skill4400605:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill4400605:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8477
	local count77 = SkillApi:LiveCount(self, caster, target,4)
	-- 8871
	if SkillJudger:Greater(self, caster, target, true,count77,0) then
	else
		return
	end
	-- 8416
	local count16 = SkillApi:BuffCount(self, caster, target,2,2,2)
	-- 8108
	if SkillJudger:Greater(self, caster, self.card, true,count16,0) then
	else
		return
	end
	-- 4400605
	local targets = SkillFilter:Exception(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[4400605], caster, target, data, 1046)
	end
	-- 4400607
	self:DelValue(SkillEffect[4400607], caster, self.card, data, "dmg4006")
end
-- 入场时
function Skill4400605:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4400606
	self:OwnerAddBuff(SkillEffect[4400606], caster, self.card, data, 1041)
end
