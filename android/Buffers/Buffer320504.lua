-- 抵抗减少（临时）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer320504 = oo.class(BuffBase)
function Buffer320504:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer320504:OnCreate(caster, target)
	-- 320504
	self:AddAttr(BufferEffect[320504], self.caster, target or self.owner, nil,"resist",-0.25)
end
-- 回合结束时
function Buffer320504:OnRoundOver(caster, target)
	-- 320506
	self:DelBufferTypeForce(BufferEffect[320506], self.caster, self.card, nil, 320501)
end
