-- 防御弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5106 = oo.class(BuffBase)
function Buffer5106:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5106:OnCreate(caster, target)
	-- 5106
	self:AddAttrPercent(BufferEffect[5106], self.caster, target or self.owner, nil,"defense",-0.3)
end
