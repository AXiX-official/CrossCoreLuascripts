-- 攻击提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4700312 = oo.class(BuffBase)
function Buffer4700312:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4700312:OnCreate(caster, target)
	-- 8475
	local c75 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"attack")
	-- 4700312
	self:AddAttr(BufferEffect[4700312], self.caster, self.card, nil, "attack",c75*0.10)
end
