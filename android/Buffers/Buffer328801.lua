-- 断剑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer328801 = oo.class(BuffBase)
function Buffer328801:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer328801:OnCreate(caster, target)
	-- 328801
	self:AddAttrPercent(BufferEffect[328801], self.caster, self.card, nil, "attack",-0.10)
end
