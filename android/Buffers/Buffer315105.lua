-- 防御强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer315105 = oo.class(BuffBase)
function Buffer315105:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer315105:OnCreate(caster, target)
	-- 315105
	self:AddAttrPercent(BufferEffect[315105], self.caster, target or self.owner, nil,"defense",0.10)
end
