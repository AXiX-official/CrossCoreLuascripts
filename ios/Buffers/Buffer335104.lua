-- 耐久上限+8%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer335104 = oo.class(BuffBase)
function Buffer335104:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer335104:OnCreate(caster, target)
	-- 335104
	self:AddMaxHpPercent(BufferEffect[335104], self.caster, target or self.owner, nil,0.8)
end
