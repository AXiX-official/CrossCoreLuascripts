-- 1100070094
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100070094 = oo.class(BuffBase)
function Buffer1100070094:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1100070094:OnCreate(caster, target)
	-- 4807
	self:AddAttr(BufferEffect[4807], self.caster, target or self.owner, nil,"damage",0.5)
	-- 5906
	self:AddAttr(BufferEffect[5906], self.caster, target or self.owner, nil,"bedamage",0.3)
end
