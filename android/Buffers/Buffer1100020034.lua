-- 乐团阵营灭刃buff3
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100020034 = oo.class(BuffBase)
function Buffer1100020034:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100020034:OnCreate(caster, target)
	-- 1100020034
	self:AddAttr(BufferEffect[1100020034], self.caster, target or self.owner, nil,"crit",0.3)
end
