-- 我方全体攻击力+10%（可叠加5层，持续5回合）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010180 = oo.class(BuffBase)
function Buffer1000010180:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010180:OnCreate(caster, target)
	-- 1000010180
	self:AddBuffCount(BufferEffect[1000010180], self.caster, self.card, nil, 1000010181,1,5)
end
