-- 禁锢打击β
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100070022 = oo.class(BuffBase)
function Buffer1100070022:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100070022:OnCreate(caster, target)
	-- 1100070024
	self:AddAttr(BufferEffect[1100070024], self.caster, target or self.owner, nil,"damage",0.2*self.nCount)
	-- 1100070025
	self:AddAttrPercent(BufferEffect[1100070025], self.caster, target or self.owner, nil,"defense",0.2*self.nCount)
end
