-- 装甲盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer100400202 = oo.class(BuffBase)
function Buffer100400202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer100400202:OnCreate(caster, target)
	-- 2105
	self:AddShield(BufferEffect[2105], self.caster, target or self.owner, nil,1,0.15)
end
