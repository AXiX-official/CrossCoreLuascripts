-- 命中强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10506 = oo.class(BuffBase)
function Buffer10506:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10506:OnCreate(caster, target)
	-- 4506
	self:AddAttr(BufferEffect[4506], self.caster, target or self.owner, nil,"hit",0.3)
end
