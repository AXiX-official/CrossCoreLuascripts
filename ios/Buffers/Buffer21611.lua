-- 攻击强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer21611 = oo.class(BuffBase)
function Buffer21611:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer21611:OnCreate(caster, target)
	-- 21611
	self:AddAttrPercent(BufferEffect[21611], self.caster, self.card, nil, "attack",0.05*self.nCount)
end
