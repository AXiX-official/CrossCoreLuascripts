-- 冲压机动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4400103 = oo.class(BuffBase)
function Buffer4400103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4400103:OnCreate(caster, target)
	-- 4400103
	self:AddAttr(BufferEffect[4400103], self.caster, target or self.owner, nil,"attack",400*self.nCount)
	-- 4400106
	self:AddAttr(BufferEffect[4400106], self.caster, target or self.owner, nil,"speed",5*self.nCount)
end
