-- 修复增益
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3303 = oo.class(BuffBase)
function Buffer3303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer3303:OnCreate(caster, target)
	-- 3303
	self:AddAttr(BufferEffect[3303], self.caster, target or self.owner, nil,"cure",0.3)
end
