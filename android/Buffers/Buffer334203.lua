-- 不显示
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer334203 = oo.class(BuffBase)
function Buffer334203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer334203:OnCreate(caster, target)
	-- 334203
	self:AddAttrPercent(BufferEffect[334203], self.caster, self.creater, nil, "attack",0.06)
end
