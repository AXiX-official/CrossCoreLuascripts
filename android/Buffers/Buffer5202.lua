-- 机动弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5202 = oo.class(BuffBase)
function Buffer5202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5202:OnCreate(caster, target)
	-- 5202
	self:AddAttr(BufferEffect[5202], self.caster, target or self.owner, nil,"speed",-10)
end
