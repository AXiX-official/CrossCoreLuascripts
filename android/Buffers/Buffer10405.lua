-- 暴伤强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10405 = oo.class(BuffBase)
function Buffer10405:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10405:OnCreate(caster, target)
	-- 4405
	self:AddAttr(BufferEffect[4405], self.caster, target or self.owner, nil,"crit",0.25)
end
