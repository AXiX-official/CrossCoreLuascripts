-- 伤害强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer331205 = oo.class(BuffBase)
function Buffer331205:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer331205:OnCreate(caster, target)
	-- 331205
	self:AddTempAttr(BufferEffect[331205], self.caster, self.card, nil, "damage",0.1*self.nCount)
end
