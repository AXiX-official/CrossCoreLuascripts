-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4402302 = oo.class(BuffBase)
function Buffer4402302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4402302:OnCreate(caster, target)
	-- 8420
	local c20 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"speed")
	-- 4402302
	self:AddAttr(BufferEffect[4402302], self.caster, self.creater, nil, "attack",c20*2)
end
