-- 减伤
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer302200203 = oo.class(BuffBase)
function Buffer302200203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer302200203:OnCreate(caster, target)
	-- 4906
	self:AddAttr(BufferEffect[4906], self.caster, target or self.owner, nil,"bedamage",-0.3)
end
