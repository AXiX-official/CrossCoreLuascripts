-- 受到修复强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4706 = oo.class(BuffBase)
function Buffer4706:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4706:OnCreate(caster, target)
	-- 4706
	self:AddAttr(BufferEffect[4706], self.caster, target or self.owner, nil,"becure",0.6)
end
