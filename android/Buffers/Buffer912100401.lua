-- 钓鱼佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer912100401 = oo.class(BuffBase)
function Buffer912100401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer912100401:OnCreate(caster, target)
	-- 5906
	self:AddAttr(BufferEffect[5906], self.caster, target or self.owner, nil,"bedamage",0.3)
end
