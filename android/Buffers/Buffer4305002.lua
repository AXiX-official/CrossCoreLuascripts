-- 伤害减少30%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4305002 = oo.class(BuffBase)
function Buffer4305002:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4305002:OnCreate(caster, target)
	-- 4305002
	self:AddAttrPercent(BufferEffect[4305002], self.caster, self.card, nil, "attack",0.10)
end
