-- 大招防御减少
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100050013 = oo.class(BuffBase)
function Buffer1100050013:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100050013:OnCreate(caster, target)
	-- 1100050013
	self:AddAttrPercent(BufferEffect[1100050013], self.caster, target or self.owner, nil,"defense",-0.4)
end
