-- 获得50点速度，持续2回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913110301 = oo.class(BuffBase)
function Buffer913110301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer913110301:OnCreate(caster, target)
	-- 4212
	self:AddAttr(BufferEffect[4212], self.caster, target or self.owner, nil,"speed",60)
end
