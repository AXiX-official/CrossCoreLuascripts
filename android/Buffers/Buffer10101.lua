-- 防御强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10101 = oo.class(BuffBase)
function Buffer10101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10101:OnCreate(caster, target)
	-- 4101
	self:AddAttrPercent(BufferEffect[4101], self.caster, target or self.owner, nil,"defense",0.05)
end
