-- 自身强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4601907 = oo.class(BuffBase)
function Buffer4601907:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4601907:OnCreate(caster, target)
	-- 4002
	self:AddAttrPercent(BufferEffect[4002], self.caster, target or self.owner, nil,"attack",0.1)
	-- 4601
	self:AddAttr(BufferEffect[4601], self.caster, target or self.owner, nil,"resist",0.05)
end
