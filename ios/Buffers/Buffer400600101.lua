-- 狂怒
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer400600101 = oo.class(BuffBase)
function Buffer400600101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer400600101:OnCreate(caster, target)
	-- 400600101
	self:AddAttr(BufferEffect[400600101], self.caster, self.card, nil, "crit_rate",0.05*self.nCount)
end
