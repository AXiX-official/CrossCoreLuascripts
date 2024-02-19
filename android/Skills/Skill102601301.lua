-- 斩铁二刀流（OD）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102601301 = oo.class(SkillBase)
function Skill102601301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102601301:DoSkill(caster, target, data)
	-- 11006
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11006], caster, target, data, 0.167,6)
end
-- 行动结束
function Skill102601301:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 102601301
	local targets = SkillFilter:MinPercentHp(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[102601301], caster, target, data, 102601301)
	end
	-- 102601311
	local targets = SkillFilter:MaxPercentHp(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[102601311], caster, target, data, 102601301)
	end
end
