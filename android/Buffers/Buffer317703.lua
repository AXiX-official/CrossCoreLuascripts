-- 伤害强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer317703 = oo.class(BuffBase)
function Buffer317703:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer317703:OnCreate(caster, target)
	-- 317703
	self:AddAttr(BufferEffect[317703], self.caster, target or self.owner, nil,"damage",0.09)
end
