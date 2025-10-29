-- 夏炙
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4402304 = oo.class(SkillBase)
function Skill4402304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4402304:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4402304
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4402304], caster, target, data, 4402302)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4402314
	local targets = SkillFilter:Group(self, caster, target, 3,4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[4402314], caster, target, data, 4402312)
	end
end
-- 伤害前
function Skill4402304:OnBefourHurt(caster, target, data)
	-- 8235
	if SkillJudger:IsCasterMech(self, caster, self.card, true,4) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8155
	if SkillJudger:IsProgressLess(self, caster, target, true,500) then
	else
		return
	end
	-- 4402324
	self:AddTempAttr(SkillEffect[4402324], caster, target, data, "defense",-400)
end
-- 攻击结束2
function Skill4402304:OnAttackOver2(caster, target, data)
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
	-- 8832
	if SkillJudger:IsProgressLess(self, caster, target, true,10) then
	else
		return
	end
	-- 8740
	local count740 = SkillApi:SkillLevel(self, caster, target,3,4023002)
	-- 4402331
	self:CallSkill(SkillEffect[4402331], caster, target, data, 402300200+count740)
end
