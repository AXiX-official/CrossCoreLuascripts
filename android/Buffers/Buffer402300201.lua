-- 暴伤强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer402300201 = oo.class(BuffBase)
function Buffer402300201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer402300201:OnCreate(caster, target)
	-- 4404
	self:AddAttr(BufferEffect[4404], self.caster, target or self.owner, nil,"crit",0.2)
end
