-- 侵蚀β
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100050022 = oo.class(BuffBase)
function Buffer1100050022:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100050022:OnCreate(caster, target)
	-- 1100050022
	self:AddAttr(BufferEffect[1100050022], self.caster, target or self.owner, nil,"attack",200*self.nCount)
end