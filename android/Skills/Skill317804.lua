-- 极寒水晶
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill317804 = oo.class(SkillBase)
function Skill317804:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill317804:OnAttackOver(caster, target, data)
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
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 8434
	local count34 = SkillApi:BuffCount(self, caster, target,2,3,3005)
	-- 8807
	if SkillJudger:Less(self, caster, self.card, true,count34,1) then
	else
		return
	end
	-- 317804
	self:HitAddBuff(SkillEffect[317804], caster, target, data, 2500,3005)
end
