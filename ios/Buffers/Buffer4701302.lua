-- 耐久上限强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4701302 = oo.class(BuffBase)
function Buffer4701302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4701302:OnCreate(caster, target)
	-- 4701302
	self:AddMaxHpPercent(BufferEffect[4701302], self.caster, target or self.owner, nil,0.14)
end
