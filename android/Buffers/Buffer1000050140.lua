-- 对拥有【弱化】效果的单位照成伤害时，获得5点np
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050140 = oo.class(BuffBase)
function Buffer1000050140:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000050140:OnAttackOver(caster, target)
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
	-- 1000050092
	if SkillJudger:HasBuff(self, self.caster, target, true,2,1000050091) then
	else
		return
	end
	-- 1000050140
	self:AddNp(BufferEffect[1000050140], self.caster, self.card, nil, 5)
end
