-- 受到修复强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer331403 = oo.class(BuffBase)
function Buffer331403:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer331403:OnCreate(caster, target)
	-- 331403
	self:AddAttr(BufferEffect[331403], self.caster, target or self.owner, nil,"becure",0.12)
end
