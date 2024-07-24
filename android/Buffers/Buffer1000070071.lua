-- 提升5%暴击伤害（可叠加，最多五层）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000070071 = oo.class(BuffBase)
function Buffer1000070071:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000070071:OnCreate(caster, target)
	-- 1000070071
	self:AddAttr(BufferEffect[1000070071], self.caster, self.card, nil, "crit",0.08)
end
