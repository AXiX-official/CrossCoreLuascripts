-- 包销
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4400201 = oo.class(BuffBase)
function Buffer4400201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4400201:OnCreate(caster, target)
	-- 4400201
	self:AddAttr(BufferEffect[4400201], self.caster, target or self.owner, nil,"speed",5*self.nCount)
end
-- 攻击结束
function Buffer4400201:OnAttackOver(caster, target)
	-- 8490
	local c90 = SkillApi:GetCount(self, self.caster, target or self.owner,4,4400201)
	-- 4400211
	self:LimitDamage(BufferEffect[4400211], self.caster, target or self.owner, nil,1,0.15*c90)
end
