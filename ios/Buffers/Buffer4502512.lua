-- 命中强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4502512 = oo.class(BuffBase)
function Buffer4502512:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4502512:OnCreate(caster, target)
	-- 4502512
	self:AddAttrPercent(BufferEffect[4502512], self.caster, target or self.owner, nil,"attack",0.03)
end
