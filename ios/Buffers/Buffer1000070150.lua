-- 战斗开始时，我方增加50点np
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000070150 = oo.class(BuffBase)
function Buffer1000070150:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000070150:OnCreate(caster, target)
	-- 1000070150
	self:AddNp(BufferEffect[1000070150], self.caster, target or self.owner, nil,15)
end
