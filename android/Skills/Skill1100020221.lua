-- 每次伤害后，若敌方低于70%血量获得1个标记，标记>7个时，获得1个额外回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020221 = oo.class(SkillBase)
function Skill1100020221:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100020221:OnAttackOver(caster, target, data)
	-- 1100020221
	local xlbbiaoji = SkillApi:GetCount(self, caster, target,1,1100020220)
end
-- 行动结束
function Skill1100020221:OnActionOver(caster, target, data)
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
	-- 1100020221
	local xlbbiaoji = SkillApi:GetCount(self, caster, target,1,1100020220)
	-- 1100020223
	if SkillJudger:Greater(self, caster, self.card, true,xlbbiaoji,7) then
	else
		return
	end
	-- 1100020227
	self:ExtraRound(SkillEffect[1100020227], caster, self.card, data, nil)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100020226
	self:DelBufferForce(SkillEffect[1100020226], caster, self.card, data, 1100020220,10)
end