-- 血量低于20%时，回复5%血量（蓝色）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020150 = oo.class(SkillBase)
function Skill1100020150:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100020150:OnAttackOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8142
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.2) then
	else
		return
	end
	-- 1100020150
	self:Cure(SkillEffect[1100020150], caster, self.card, data, 1,0.05)
end
