-- 增加伤害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5600002 = oo.class(BuffBase)
function Buffer5600002:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5600002:OnCreate(caster, target)
	-- 4804
	self:AddAttr(BufferEffect[4804], self.caster, target or self.owner, nil,"damage",0.2)
end
