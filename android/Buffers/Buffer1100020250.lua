-- 血量比标记
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100020250 = oo.class(BuffBase)
function Buffer1100020250:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100020250:OnCreate(caster, target)
	-- 1100020250
	self:AddAttrPercent(BufferEffect[1100020250], self.caster, target or self.owner, nil,"attack",0.05)
end
