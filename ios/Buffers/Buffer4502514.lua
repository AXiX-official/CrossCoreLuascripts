-- 命中强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4502514 = oo.class(BuffBase)
function Buffer4502514:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4502514:OnCreate(caster, target)
	-- 4502514
	self:AddAttrPercent(BufferEffect[4502514], self.caster, target or self.owner, nil,"attack",0.05)
end
