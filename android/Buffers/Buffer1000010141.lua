-- 速度提高16%，持续2回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010141 = oo.class(BuffBase)
function Buffer1000010141:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010141:OnCreate(caster, target)
	-- 1000010141
	self:AddTempAttrPercent(BufferEffect[1000010141], self.caster, target or self.owner, nil,"speed",0.16)
end
