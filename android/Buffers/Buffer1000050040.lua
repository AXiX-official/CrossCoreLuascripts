-- 战斗开始时，我方每有一个角色增加10点np
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050040 = oo.class(BuffBase)
function Buffer1000050040:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 入场时
function Buffer1000050040:OnBorn(caster, target)
	-- 1000050040
	self:AddNp(BufferEffect[1000050040], self.caster, self.card, nil, 10)
end
