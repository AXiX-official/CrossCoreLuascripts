-- 我方全体+16%攻击（2级）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000070020 = oo.class(BuffBase)
function Buffer1000070020:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000070020:OnCreate(caster, target)
	-- 1000070020
	self:AddAttrPercent(BufferEffect[1000070020], self.caster, target or self.owner, nil,"attack",0.32)
end
