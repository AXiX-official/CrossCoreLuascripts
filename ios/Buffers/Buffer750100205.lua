-- 运势
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer750100205 = oo.class(BuffBase)
function Buffer750100205:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer750100205:OnCreate(caster, target)
	-- 750100205
	self:AddAttrPercent(BufferEffect[750100205], self.caster, target or self.owner, nil,"crit_rate",0.15)
	-- 750100210
	self:AddAttrPercent(BufferEffect[750100210], self.caster, target or self.owner, nil,"attack",0.02)
end
