-- 极速应对
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer327702 = oo.class(BuffBase)
function Buffer327702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer327702:OnCreate(caster, target)
	-- 327702
	self:AddAttr(BufferEffect[327702], self.caster, target or self.owner, nil,"speed",20)
end
