-- 蠢动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer332515 = oo.class(BuffBase)
function Buffer332515:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer332515:OnCreate(caster, target)
	-- 332515
	self:AddAttr(BufferEffect[332515], self.caster, target or self.owner, nil,"defense",-30)
end
