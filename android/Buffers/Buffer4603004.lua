-- 4603004_Buff_name##
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4603004 = oo.class(BuffBase)
function Buffer4603004:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4603004:OnCreate(caster, target)
	-- 8468
	local c68 = SkillApi:GetDamage(self, self.caster, target or self.owner,3)
	-- 4603034
	self:AddAttr(BufferEffect[4603034], self.caster, self.card, nil, "attack",math.floor(math.min(c68*0.04,2000)))
	-- 8468
	local c68 = SkillApi:GetDamage(self, self.caster, target or self.owner,3)
	-- 4603044
	self:AddAttr(BufferEffect[4603044], self.caster, self.creater, nil, "attack",math.floor(math.min(c68*0.04,2000)))
end
