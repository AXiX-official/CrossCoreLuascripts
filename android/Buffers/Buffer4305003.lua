-- 攻击增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4305003 = oo.class(BuffBase)
function Buffer4305003:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4305003:OnCreate(caster, target)
	-- 4305003
	self:AddAttrPercent(BufferEffect[4305003], self.caster, self.card, nil, "attack",0.09)
end
