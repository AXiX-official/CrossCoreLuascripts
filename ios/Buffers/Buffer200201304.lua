-- 暴击强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200201304 = oo.class(BuffBase)
function Buffer200201304:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200201304:OnCreate(caster, target)
	-- 200201304
	self:AddAttr(BufferEffect[200201304], self.caster, target or self.owner, nil,"crit_rate",0.30)
end
