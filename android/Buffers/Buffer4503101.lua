-- 肉体摧毁
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4503101 = oo.class(BuffBase)
function Buffer4503101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4503101:OnCreate(caster, target)
	-- 4503101
	self:AddMaxHpPercent(BufferEffect[4503101], self.caster, self.card, nil, -0.05,-10000)
end
