-- 受到伤害强化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000214 = oo.class(BuffBase)
function Buffer1000214:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000214:OnCreate(caster, target)
	-- 1000214
	self:AddAttr(BufferEffect[1000214], self.caster, target or self.owner, nil,"bedamage",0.25)
end
