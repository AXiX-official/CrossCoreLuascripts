-- 吸收护盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2101 = oo.class(BuffBase)
function Buffer2101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2101:OnCreate(caster, target)
	-- 2101
	self:AddShield(BufferEffect[2101], self.caster, target or self.owner, nil,1,0.05)
end