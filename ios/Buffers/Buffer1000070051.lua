-- 【癫狂】效果：增加5%暴击几率（可叠加，最多5层）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000070051 = oo.class(BuffBase)
function Buffer1000070051:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000070051:OnCreate(caster, target)
	-- 1000070051
	self:AddAttr(BufferEffect[1000070051], self.caster, target or self.owner, nil,"crit_rate",0.05)
end
