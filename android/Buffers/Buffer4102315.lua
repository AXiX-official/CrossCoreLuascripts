-- 攻击降低
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4102315 = oo.class(BuffBase)
function Buffer4102315:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4102315:OnCreate(caster, target)
	-- 4102315
	self:AddAttrPercent(BufferEffect[4102315], self.caster, target or self.owner, nil,"attack",-0.30)
end
