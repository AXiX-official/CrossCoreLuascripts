-- 角色释放大招后，若该次是非伤害技能，则为自身提高66%伤害，持续1回合。最多叠加2次
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050170 = oo.class(BuffBase)
function Buffer1000050170:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000050170:OnAttackOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 8260
	if SkillJudger:IsCanHurt(self, self.caster, target, false) then
	else
		return
	end
	-- 1000050170
	self:OwnerAddBuff(BufferEffect[1000050170], self.caster, self.card, nil, 1000050171)
end
