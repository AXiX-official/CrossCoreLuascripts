-- 抵抗削弱
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill324403 = oo.class(SkillBase)
function Skill324403:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill324403:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 324403
	self:HitAddBuff(SkillEffect[324403], caster, target, data, 6000,5606)
end
