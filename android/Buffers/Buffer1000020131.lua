-- 提高50%伤害，持续1回合。最多叠加2次
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020131 = oo.class(BuffBase)
function Buffer1000020131:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000020131:OnCreate(caster, target)
	-- 1000020131
	self:AddAttrPercent(BufferEffect[1000020131], self.caster, self.card, nil, "damage",0.5)
end
