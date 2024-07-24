-- 战斗开始后，我方全体获得提升反击伤害的buff，持续3回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000070060 = oo.class(BuffBase)
function Buffer1000070060:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000070060:OnCreate(caster, target)
	-- 1000070060
	self:AddBuff(BufferEffect[1000070060], self.caster, target or self.owner, nil,1000070061)
end
