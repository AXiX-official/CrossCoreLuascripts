-- 炼钢
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer704200203 = oo.class(BuffBase)
function Buffer704200203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer704200203:OnCreate(caster, target)
	-- 4604
	self:AddAttr(BufferEffect[4604], self.caster, target or self.owner, nil,"resist",0.2)
	-- 4404
	self:AddAttr(BufferEffect[4404], self.caster, target or self.owner, nil,"crit",0.2)
end
