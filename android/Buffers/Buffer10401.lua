-- 暴伤强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10401 = oo.class(BuffBase)
function Buffer10401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10401:OnCreate(caster, target)
	-- 4401
	self:AddAttr(BufferEffect[4401], self.caster, target or self.owner, nil,"crit",0.05)
end
