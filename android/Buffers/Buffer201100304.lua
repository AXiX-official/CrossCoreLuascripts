-- 伤害强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer201100304 = oo.class(BuffBase)
function Buffer201100304:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer201100304:OnCreate(caster, target)
	-- 201100304
	self:AddProgress(BufferEffect[201100304], self.caster, self.card, nil, 200)
	-- 201100312
	self:AddAttr(BufferEffect[201100312], self.caster, self.card, nil, "damage",0.15)
	-- 201100321
	self:Cure(BufferEffect[201100321], self.caster, self.card, nil, 8,0.1)
end
