-- 防御弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1040204 = oo.class(BuffBase)
function Buffer1040204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1040204:OnCreate(caster, target)
	-- 1040204
	self:AddAttrPercent(BufferEffect[1040204], self.caster, target or self.owner, nil,"defense",-0.23)
end
