-- 易伤
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5904 = oo.class(BuffBase)
function Buffer5904:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5904:OnCreate(caster, target)
	-- 5904
	self:AddAttr(BufferEffect[5904], self.caster, target or self.owner, nil,"bedamage",0.2)
end
