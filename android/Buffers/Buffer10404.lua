-- 暴伤强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10404 = oo.class(BuffBase)
function Buffer10404:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10404:OnCreate(caster, target)
	-- 4404
	self:AddAttr(BufferEffect[4404], self.caster, target or self.owner, nil,"crit",0.2)
end
