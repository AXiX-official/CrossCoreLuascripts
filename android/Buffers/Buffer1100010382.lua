-- 护盾神威
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010382 = oo.class(BuffBase)
function Buffer1100010382:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100010382:OnCreate(caster, target)
	-- 1100010384
	self:AddAttr(BufferEffect[1100010384], self.caster, target or self.owner, nil,"crit",0.4*self.nCount)
end