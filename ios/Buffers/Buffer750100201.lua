-- 运势
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer750100201 = oo.class(BuffBase)
function Buffer750100201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer750100201:OnCreate(caster, target)
	-- 750100201
	self:AddAttrPercent(BufferEffect[750100201], self.caster, target or self.owner, nil,"crit_rate",0.15)
	-- 750100206
	self:AddAttrPercent(BufferEffect[750100206], self.caster, target or self.owner, nil,"attack",0.02)
end
