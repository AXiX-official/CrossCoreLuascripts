-- 火焰
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4302704 = oo.class(BuffBase)
function Buffer4302704:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4302704:OnCreate(caster, target)
	-- 4302704
	self:AddAttr(BufferEffect[4302704], self.caster, target or self.owner, nil,"crit_rate",-0.16)
end
