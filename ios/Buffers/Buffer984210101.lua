-- 防御削减
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984210101 = oo.class(BuffBase)
function Buffer984210101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984210101:OnCreate(caster, target)
	-- 984210101
	self:AddAttr(BufferEffect[984210101], self.caster, target or self.owner, nil,"defense",-0.15)
end
