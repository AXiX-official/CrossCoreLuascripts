-- 暴击弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5302 = oo.class(BuffBase)
function Buffer5302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5302:OnCreate(caster, target)
	-- 5302
	self:AddAttr(BufferEffect[5302], self.caster, target or self.owner, nil,"crit_rate",-0.1)
end
