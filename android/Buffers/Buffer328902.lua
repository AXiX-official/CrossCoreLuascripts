-- 遗祸
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer328902 = oo.class(BuffBase)
function Buffer328902:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer328902:OnCreate(caster, target)
	-- 328902
	self:AddAttrPercent(BufferEffect[328902], self.caster, self.card, nil, "attack",0.06*self.nCount)
end
