-- 防御提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4101204 = oo.class(BuffBase)
function Buffer4101204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4101204:OnCreate(caster, target)
	-- 4105
	self:AddAttrPercent(BufferEffect[4105], self.caster, target or self.owner, nil,"defense",0.25)
end
