-- 造成物理伤害时，概率获得暴击率+20%，持续2回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030040 = oo.class(BuffBase)
function Buffer1000030040:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害后
function Buffer1000030040:OnAfterHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsDamageType(self, self.caster, target, true,1) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 1000030040
	self:AddBuff(BufferEffect[1000030040], self.caster, self.card, nil, 1000030041)
end
