-- 命中强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984000804 = oo.class(BuffBase)
function Buffer984000804:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984000804:OnCreate(caster, target)
	-- 4504
	self:AddAttr(BufferEffect[4504], self.caster, target or self.owner, nil,"hit",0.2)
end
