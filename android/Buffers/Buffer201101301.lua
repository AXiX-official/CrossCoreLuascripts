-- 伤害强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer201101301 = oo.class(BuffBase)
function Buffer201101301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer201101301:OnCreate(caster, target)
	-- 201101301
	self:AddProgress(BufferEffect[201101301], self.caster, self.card, nil, 200)
	-- 201101311
	self:AddAttr(BufferEffect[201101311], self.caster, self.card, nil, "damage",0.15)
	-- 201101321
	self:Cure(BufferEffect[201101321], self.caster, self.card, nil, 8,0.2)
end
