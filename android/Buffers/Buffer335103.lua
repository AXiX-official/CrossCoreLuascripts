-- 耐久上限+6%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer335103 = oo.class(BuffBase)
function Buffer335103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer335103:OnCreate(caster, target)
	-- 335103
	self:AddMaxHpPercent(BufferEffect[335103], self.caster, target or self.owner, nil,0.06)
end
