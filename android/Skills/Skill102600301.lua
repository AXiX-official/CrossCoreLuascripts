-- 斩铁二刀流
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102600301 = oo.class(SkillBase)
function Skill102600301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102600301:DoSkill(caster, target, data)
	-- 11006
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11006], caster, target, data, 0.167,6)
end
-- 行动结束
function Skill102600301:OnActionOver(caster, target, data)
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
	-- 102600301
	local targets = SkillFilter:MinPercentHp(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[102600301], caster, target, data, 102600301)
	end
	-- 102600311
	local targets = SkillFilter:MaxPercentHp(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[102600311], caster, target, data, 102600301)
	end
end
