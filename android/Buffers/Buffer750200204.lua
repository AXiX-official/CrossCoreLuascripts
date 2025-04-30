-- 运势
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer750200204 = oo.class(BuffBase)
function Buffer750200204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer750200204:OnCreate(caster, target)
	-- 750200204
	self:AddAttrPercent(BufferEffect[750200204], self.caster, target or self.owner, nil,"crit_rate",0.15)
	-- 750200209
	self:AddProgress(BufferEffect[750200209], self.caster, target or self.owner, nil,500)
end
