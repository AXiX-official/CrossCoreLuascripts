-- 抵抗减少（临时）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer320404 = oo.class(BuffBase)
function Buffer320404:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer320404:OnCreate(caster, target)
	-- 320404
	self:AddAttr(BufferEffect[320404], self.caster, target or self.owner, nil,"resist",-0.4)
end
-- 回合结束时
function Buffer320404:OnRoundOver(caster, target)
	-- 320406
	self:DelBufferTypeForce(BufferEffect[320406], self.caster, self.card, nil, 320401)
end
