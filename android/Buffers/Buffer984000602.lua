-- 故障状态
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984000602 = oo.class(BuffBase)
function Buffer984000602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984000602:OnCreate(caster, target)
	-- 5006
	self:AddAttrPercent(BufferEffect[5006], self.caster, target or self.owner, nil,"attack",-0.3)
end
