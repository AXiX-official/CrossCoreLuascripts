-- 共鸣：强化Ⅰ
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050021 = oo.class(BuffBase)
function Buffer1000050021:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000050021:OnCreate(caster, target)
	-- 1000050021
	self:AddAttrPercent(BufferEffect[1000050021], self.caster, self.card, nil, "attack",0.08*self.nCount)
end
