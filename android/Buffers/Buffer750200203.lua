-- 攻击强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer750200203 = oo.class(BuffBase)
function Buffer750200203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer750200203:OnCreate(caster, target)
	-- 4003
	self:AddAttrPercent(BufferEffect[4003], self.caster, target or self.owner, nil,"attack",0.15)
end
