-- 攻击强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10002 = oo.class(BuffBase)
function Buffer10002:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10002:OnCreate(caster, target)
	-- 4002
	self:AddAttrPercent(BufferEffect[4002], self.caster, target or self.owner, nil,"attack",0.1)
end
