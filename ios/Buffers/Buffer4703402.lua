-- 防御强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4703402 = oo.class(BuffBase)
function Buffer4703402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4703402:OnCreate(caster, target)
	-- 4703402
	self:AddAttrPercent(BufferEffect[4703402], self.caster, target or self.owner, nil,"defense",0.10)
end
