-- 斩铁二刀流
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102600302 = oo.class(SkillBase)
function Skill102600302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102600302:DoSkill(caster, target, data)
	-- 11006
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11006], caster, target, data, 0.167,6)
end
-- 行动结束
function Skill102600302:OnActionOver(caster, target, data)
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
	-- 102600302
	local targets = SkillFilter:MinPercentHp(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[102600302], caster, target, data, 102600302)
	end
	-- 102600312
	local targets = SkillFilter:MaxPercentHp(self, caster, target, 2,"hp",1)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[102600312], caster, target, data, 102600302)
	end
end
