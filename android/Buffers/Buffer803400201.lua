-- 吸收护盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer803400201 = oo.class(BuffBase)
function Buffer803400201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer803400201:OnCreate(caster, target)
	-- 2123
	self:AddShield(BufferEffect[2123], self.caster, target or self.owner, nil,1,0.24)
end
