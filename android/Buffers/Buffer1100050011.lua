-- 侵蚀α
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100050011 = oo.class(BuffBase)
function Buffer1100050011:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100050011:OnCreate(caster, target)
	-- 1100050011
	self:AddAttr(BufferEffect[1100050011], self.caster, target or self.owner, nil,"damage",0.02*self.nCount)
end
