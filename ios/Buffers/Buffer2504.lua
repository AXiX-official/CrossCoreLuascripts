-- 合金盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2504 = oo.class(BuffBase)
function Buffer2504:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer2504:OnCreate(caster, target)
	-- 2504
	self:AddShieldWall(BufferEffect[2504], self.caster, target or self.owner, nil,1,0.54)
end
