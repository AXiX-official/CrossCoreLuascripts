-- 蠢动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer332513 = oo.class(BuffBase)
function Buffer332513:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer332513:OnCreate(caster, target)
	-- 332513
	self:AddAttr(BufferEffect[332513], self.caster, target or self.owner, nil,"defense",-18)
end
