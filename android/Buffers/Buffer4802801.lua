-- 传送者之速
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4802801 = oo.class(BuffBase)
function Buffer4802801:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4802801:OnCreate(caster, target)
	-- 8482
	local c82 = SkillApi:GetAttr(self, self.caster, target or self.owner,6,"speed")
	-- 4802801
	self:AddAttr(BufferEffect[4802801], self.caster, self.card, nil, "speed",math.floor(c82*0.2))
end
