-- 暴伤弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5406 = oo.class(BuffBase)
function Buffer5406:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5406:OnCreate(caster, target)
	-- 5406
	self:AddAttr(BufferEffect[5406], self.caster, target or self.owner, nil,"crit",-0.3)
end
