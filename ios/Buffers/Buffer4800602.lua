-- 极限强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4800602 = oo.class(BuffBase)
function Buffer4800602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4800602:OnCreate(caster, target)
	-- 4203
	self:AddAttr(BufferEffect[4203], self.caster, target or self.owner, nil,"speed",15)
	-- 4503
	self:AddAttr(BufferEffect[4503], self.caster, target or self.owner, nil,"hit",0.15)
end
