-- 自身强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer316904 = oo.class(BuffBase)
function Buffer316904:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer316904:OnCreate(caster, target)
	-- 4105
	self:AddAttrPercent(BufferEffect[4105], self.caster, target or self.owner, nil,"defense",0.25)
	-- 4505
	self:AddAttr(BufferEffect[4505], self.caster, target or self.owner, nil,"hit",0.25)
end
