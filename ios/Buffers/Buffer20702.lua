-- 修复增益
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer20702 = oo.class(BuffBase)
function Buffer20702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer20702:OnCreate(caster, target)
	-- 3302
	self:AddAttr(BufferEffect[3302], self.caster, target or self.owner, nil,"cure",0.2)
end
