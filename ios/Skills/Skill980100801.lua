-- 超频
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980100801 = oo.class(SkillBase)
function Skill980100801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill980100801:OnAttackOver(caster, target, data)
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
	-- 8143
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.3) then
	else
		return
	end
	-- 980100801
	self:AddUplimitBuff(SkillEffect[980100801], caster, self.card, data, 3,3,980100801,1,980100801)
end
