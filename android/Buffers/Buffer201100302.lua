-- 伤害强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer201100302 = oo.class(BuffBase)
function Buffer201100302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer201100302:OnCreate(caster, target)
	-- 201100302
	self:AddProgress(BufferEffect[201100302], self.caster, self.card, nil, 150)
	-- 201100311
	self:AddAttr(BufferEffect[201100311], self.caster, self.card, nil, "damage",0.1)
	-- 201100321
	self:Cure(BufferEffect[201100321], self.caster, self.card, nil, 8,0.1)
end
