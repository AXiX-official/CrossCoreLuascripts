-- 伤害提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer330802 = oo.class(BuffBase)
function Buffer330802:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer330802:OnCreate(caster, target)
	-- 330802
	self:AddAttr(BufferEffect[330802], self.caster, self.card, nil, "damage",0.10)
end
