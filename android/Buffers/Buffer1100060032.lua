-- 肉鸽灭刃阵营角色普攻后防御降低
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100060032 = oo.class(BuffBase)
function Buffer1100060032:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100060032:OnCreate(caster, target)
	-- 1100060032
	self:AddAttrPercent(BufferEffect[1100060032], self.caster, target or self.owner, nil,"defense",-0.08)
end