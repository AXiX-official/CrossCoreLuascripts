-- 减伤
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200801312 = oo.class(BuffBase)
function Buffer200801312:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200801312:OnCreate(caster, target)
	-- 200801312
	self:AddAttr(BufferEffect[200801312], self.caster, self.card, nil, "bedamage",-0.15)
end
