-- 易伤
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer932900702 = oo.class(BuffBase)
function Buffer932900702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer932900702:OnCreate(caster, target)
	-- 932900703
	self:AddAttr(BufferEffect[932900703], self.caster, self.card, nil, "bedamage",0.2)
	-- 932900704
	self:AddProgress(BufferEffect[932900704], self.caster, self.card, nil, -500)
end
