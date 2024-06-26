-- 修复效果-30%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984010803 = oo.class(BuffBase)
function Buffer984010803:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984010803:OnCreate(caster, target)
	-- 5704
	self:AddAttr(BufferEffect[5704], self.caster, target or self.owner, nil,"becure",-0.4)
end
