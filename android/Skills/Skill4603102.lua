-- 提泽纳
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4603102 = oo.class(SkillBase)
function Skill4603102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4603102:OnAttackOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 4603102
	self:HitAddBuffCount(SkillEffect[4603102], caster, target, data, 2500,603100101,1,999)
end
-- 行动结束
function Skill4603102:OnActionOver(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4603112
	self:OwnerAddBuff(SkillEffect[4603112], caster, caster, data, 4603102)
end
