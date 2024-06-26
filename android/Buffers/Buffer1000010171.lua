-- +16%机动buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010171 = oo.class(BuffBase)
function Buffer1000010171:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010171:OnCreate(caster, target)
	-- 1000010171
	self:AddAttrPercent(BufferEffect[1000010171], self.caster, target or self.owner, nil,"speed",0.16)
end
