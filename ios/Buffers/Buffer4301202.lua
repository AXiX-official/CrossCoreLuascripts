-- 机动强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4301202 = oo.class(BuffBase)
function Buffer4301202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4301202:OnCreate(caster, target)
	-- 4301202
	self:AddAttr(BufferEffect[4301202], self.caster, target or self.owner, nil,"speed",4*self.nCount)
end
