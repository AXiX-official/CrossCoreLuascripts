-- 熔铄
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer704300204 = oo.class(BuffBase)
function Buffer704300204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer704300204:OnCreate(caster, target)
	-- 4004
	self:AddAttrPercent(BufferEffect[4004], self.caster, target or self.owner, nil,"attack",0.2)
	-- 4103
	self:AddAttrPercent(BufferEffect[4103], self.caster, target or self.owner, nil,"defense",0.15)
end
