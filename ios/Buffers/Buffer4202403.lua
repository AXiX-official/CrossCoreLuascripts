-- 风笛
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4202403 = oo.class(BuffBase)
function Buffer4202403:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4202403:OnCreate(caster, target)
	-- 4202403
	self:AddAttr(BufferEffect[4202403], self.caster, self.card, nil, "bedamage",-0.06*self.nCount)
end
