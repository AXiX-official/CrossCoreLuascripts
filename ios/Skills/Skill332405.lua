-- 信风4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill332405 = oo.class(SkillBase)
function Skill332405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill332405:OnRoundOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 332405
	if self:Rand(10000) then
		self:AddBuffCount(SkillEffect[332405], caster, self.card, data, 332401,1,5)
	end
end
-- 行动结束
function Skill332405:OnActionOver(caster, target, data)
	-- 8672
	local count672 = SkillApi:GetCount(self, caster, target,3,332401)
	-- 8881
	if SkillJudger:GreaterEqual(self, caster, target, true,count672,5) then
	else
		return
	end
	-- 332411
	self:DelBufferGroup(SkillEffect[332411], caster, self.card, data, 1,5)
	-- 332412
	self:DelBufferForce(SkillEffect[332412], caster, self.card, data, 332401)
	-- 332413
	self:CallSkill(SkillEffect[332413], caster, target, data, 400200201)
end
