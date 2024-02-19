-- 包销
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4400204 = oo.class(BuffBase)
function Buffer4400204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4400204:OnCreate(caster, target)
	-- 4400203
	self:AddAttr(BufferEffect[4400203], self.caster, target or self.owner, nil,"speed",15*self.nCount)
end
-- 攻击结束
function Buffer4400204:OnAttackOver(caster, target)
	-- 8491
	local c91 = SkillApi:GetCount(self, self.caster, target or self.owner,4,4400202)
	-- 4400212
	self:LimitDamage(BufferEffect[4400212], self.caster, target or self.owner, nil,1,0.2*c91)
end
