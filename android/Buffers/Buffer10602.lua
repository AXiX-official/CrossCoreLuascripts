-- 抵抗强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10602 = oo.class(BuffBase)
function Buffer10602:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10602:OnCreate(caster, target)
	-- 4602
	self:AddAttr(BufferEffect[4602], self.caster, target or self.owner, nil,"resist",0.1)
end
