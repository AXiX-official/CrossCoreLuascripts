-- 受到修复弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5704 = oo.class(BuffBase)
function Buffer5704:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5704:OnCreate(caster, target)
	-- 5704
	self:AddAttr(BufferEffect[5704], self.caster, target or self.owner, nil,"becure",-0.4)
end
