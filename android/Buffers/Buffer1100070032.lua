-- 肉鸽碎星阵营角色怪物被控制防御下降
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100070032 = oo.class(BuffBase)
function Buffer1100070032:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100070032:OnCreate(caster, target)
	-- 1100070032
	self:AddAttrPercent(BufferEffect[1100070032], self.caster, target or self.owner, nil,"defense",-0.1*self.nCount)
end
