-- 极速抵御
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer327605 = oo.class(BuffBase)
function Buffer327605:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer327605:OnCreate(caster, target)
	-- 327605
	self:AddAttr(BufferEffect[327605], self.caster, target or self.owner, nil,"bedamage",-0.5)
	-- 327615
	self:AddAttr(BufferEffect[327615], self.caster, target or self.owner, nil,"resist",0.5)
end
