-- 蜇刺
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4501404 = oo.class(SkillBase)
function Skill4501404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4501404:OnAttackOver(caster, target, data)
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
	-- 8455
	local count55 = SkillApi:SkillLevel(self, caster, target,3,45014)
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 4501404
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[4501404], caster, target, data, 5901+count55)
	end
end