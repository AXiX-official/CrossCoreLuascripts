-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6117 = oo.class(BuffBase)
function Buffer6117:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer6117:OnRoundBegin(caster, target)
	self:ImmuneBuffID(BufferEffect[6115], self.caster, self.owner, nil,3006)
end
