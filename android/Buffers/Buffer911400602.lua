-- 成虫盘
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer911400602 = oo.class(BuffBase)
function Buffer911400602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer911400602:OnCreate(caster, target)
	-- 911400603
	self:AddAttrPercent(BufferEffect[911400603], self.caster, self.card, nil, "attack",0.2)
	-- 911400602
	self:AddAttrPercent(BufferEffect[911400602], self.caster, self.card, nil, "defense",-0.2)
end
