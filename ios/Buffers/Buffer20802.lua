-- 吸收护盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer20802 = oo.class(BuffBase)
function Buffer20802:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer20802:OnCreate(caster, target)
	-- 20802
	self:AddShield(BufferEffect[20802], self.caster, self.card, nil, 6,0.30)
	-- 20805
	self:AddAttrPercent(BufferEffect[20805], self.caster, self.card, nil, "attack",0.30)
end
