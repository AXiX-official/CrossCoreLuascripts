-- 强化剂
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4500104 = oo.class(BuffBase)
function Buffer4500104:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4500104:OnCreate(caster, target)
	-- 4001
	self:AddAttrPercent(BufferEffect[4001], self.caster, target or self.owner, nil,"attack",0.05)
	-- 4201
	self:AddAttr(BufferEffect[4201], self.caster, target or self.owner, nil,"speed",5)
	-- 4504
	self:AddAttr(BufferEffect[4504], self.caster, target or self.owner, nil,"hit",0.2)
end
