-- 1100070084
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100070084 = oo.class(BuffBase)
function Buffer1100070084:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 死亡时
function Buffer1100070084:OnDeath(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1100070084
	self:PassiveRevive(BufferEffect[1100070084], self.caster, self.card, nil, 8,0.5,{progress=1000})
end
