-- 自身护盾被打爆时，获得自身血量25%护盾值，每场战斗每个角色仅生效一次
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020110 = oo.class(BuffBase)
function Buffer1000020110:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000020110:OnAttackOver(caster, target)
	-- 8218
	if SkillJudger:IsShieldDestroy(self, self.caster, target, true) then
	else
		return
	end
	-- 1000020114
	if SkillJudger:Less(self, self.caster, self.card, true,b001,1) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000020110
	self:AddBuff(BufferEffect[1000020110], self.caster, self.card, nil, 1000020111,1000020112)
end
