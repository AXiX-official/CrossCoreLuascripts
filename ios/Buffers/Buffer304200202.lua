-- 喵之守护
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer304200202 = oo.class(BuffBase)
function Buffer304200202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer304200202:OnCreate(caster, target)
	-- 2912
	self:AddReduceShield(BufferEffect[2912], self.caster, target or self.owner, nil,0.3,3,0.4)
end
-- 攻击结束
function Buffer304200202:OnAttackOver(caster, target)
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
	-- 304200217
	self:DelBufferTypeForce(BufferEffect[304200217], self.caster, self.card, nil, 30420)
end
