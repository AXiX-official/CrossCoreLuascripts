-- 攻击提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer334505 = oo.class(BuffBase)
function Buffer334505:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer334505:OnCreate(caster, target)
	-- 4601505
	self:AddAttr(BufferEffect[4601505], self.caster, self.card, nil, "attack",150*self.nCount)
end