-- 对拥有控制状态的目标造成伤害时概率退条
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000060090 = oo.class(BuffBase)
function Buffer1000060090:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000060090:OnAttackOver(caster, target)
	-- 8261
	if SkillJudger:HasBuff(self, self.caster, target, true,2,1,1) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 1000060090
	self:AddProgress(BufferEffect[1000060090], self.caster, self.card, nil, -100)
end
