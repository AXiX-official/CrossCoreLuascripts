-- 天赋效果310801
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill310801 = oo.class(SkillBase)
function Skill310801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill310801:OnAttackOver(caster, target, data)
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
	-- 8439
	local count39 = SkillApi:SkillLevel(self, caster, target,3,3108)
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 310801
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[310801], caster, target, data, 5901+count39)
	end
end
