-- 恐惧咆哮
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4302604 = oo.class(SkillBase)
function Skill4302604:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4302604:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4302604
	self:CallSkillEx(SkillEffect[4302604], caster, self.card, data, 302600403)
	-- 4302611
	self:AddBuff(SkillEffect[4302611], caster, self.card, data, 4302601)
end
-- 回合开始处理完成后
function Skill4302604:OnAfterRoundBegin(caster, target, data)
	-- 8147
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.7) then
	else
		return
	end
	-- 8659
	local count659 = SkillApi:BuffCount(self, caster, target,3,4,4302601)
	-- 8865
	if SkillJudger:Greater(self, caster, target, true,count659,0) then
	else
		return
	end
	-- 4302613
	self:DelBufferTypeForce(SkillEffect[4302613], caster, self.card, data, 4302601)
	-- 4302615
	self:DelBufferGroup(SkillEffect[4302615], caster, self.card, data, 1,5)
	-- 4302606
	self:CallSkill(SkillEffect[4302606], caster, self.card, data, 302600403)
end
-- 行动结束
function Skill4302604:OnActionOver(caster, target, data)
	-- 8147
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.7) then
	else
		return
	end
	-- 8659
	local count659 = SkillApi:BuffCount(self, caster, target,3,4,4302601)
	-- 8865
	if SkillJudger:Greater(self, caster, target, true,count659,0) then
	else
		return
	end
	-- 4302613
	self:DelBufferTypeForce(SkillEffect[4302613], caster, self.card, data, 4302601)
	-- 4302615
	self:DelBufferGroup(SkillEffect[4302615], caster, self.card, data, 1,5)
	-- 4302606
	self:CallSkill(SkillEffect[4302606], caster, self.card, data, 302600403)
end
