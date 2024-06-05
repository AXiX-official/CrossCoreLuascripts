-- 不显示
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer334202 = oo.class(BuffBase)
function Buffer334202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer334202:OnCreate(caster, target)
	-- 334202
	self:AddAttrPercent(BufferEffect[334202], self.caster, self.creater, nil, "attack",0.04)
end
