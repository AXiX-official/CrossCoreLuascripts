-- 碰撞力场
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010391 = oo.class(BuffBase)
function Buffer1100010391:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010391:OnCreate(caster, target)
	-- 1100010393
	self:AddAttrPercent(BufferEffect[1100010393], self.caster, target or self.owner, nil,"attack",0.1*self.nCount)
	-- 1100010394
	self:AddAttr(BufferEffect[1100010394], self.caster, target or self.owner, nil,"crit",0.1*self.nCount)
	-- 1100010395
	self:AddAttrPercent(BufferEffect[1100010395], self.caster, target or self.owner, nil,"defense",-0.1*self.nCount)
end
