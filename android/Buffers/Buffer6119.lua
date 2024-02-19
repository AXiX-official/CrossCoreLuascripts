-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6119 = oo.class(BuffBase)
function Buffer6119:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer6119:OnRoundBegin(caster, target)
	self:ImmuneBuffID(BufferEffect[6117], self.caster, self.owner, nil,3008)
end
