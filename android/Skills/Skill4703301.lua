-- 真理天秤
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4703301 = oo.class(SkillBase)
function Skill4703301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4703301:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703306
	self:AddBuff(SkillEffect[4703306], caster, self.card, data, 4703306)
end
-- 攻击结束
function Skill4703301:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8099
	if SkillJudger:TargetPercentHp(self, caster, target, false,0.3) then
	else
		return
	end
	-- 8665
	local count665 = SkillApi:BuffCount(self, caster, target,3,4,4703306)
	-- 8872
	if SkillJudger:Greater(self, caster, target, true,count665,0) then
	else
		return
	end
	-- 4703301
	self:CallSkill(SkillEffect[4703301], caster, self.card, data, 703300401)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4703307
	self:DelBufferTypeForce(SkillEffect[4703307], caster, self.card, data, 4703306)
end
