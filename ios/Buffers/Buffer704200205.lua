-- 炼钢
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer704200205 = oo.class(BuffBase)
function Buffer704200205:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer704200205:OnCreate(caster, target)
	-- 4606
	self:AddAttr(BufferEffect[4606], self.caster, target or self.owner, nil,"resist",0.3)
	-- 4406
	self:AddAttr(BufferEffect[4406], self.caster, target or self.owner, nil,"crit",0.3)
end
