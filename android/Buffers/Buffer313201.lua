-- 攻击强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer313201 = oo.class(BuffBase)
function Buffer313201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer313201:OnCreate(caster, target)
	-- 4001
	self:AddAttrPercent(BufferEffect[4001], self.caster, target or self.owner, nil,"attack",0.05)
end
