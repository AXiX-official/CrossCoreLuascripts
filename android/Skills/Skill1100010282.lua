-- 攻击时100%几率驱散目标1-2个增益效果
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010282 = oo.class(SkillBase)
function Skill1100010282:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击开始
function Skill1100010282:OnAttackBegin(caster, target, data)
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
	-- 1100010282
	if self:Rand(10000) then
		self:DelBufferGroup(SkillEffect[1100010282], caster, target, data, 2,1,2)
	end
end
