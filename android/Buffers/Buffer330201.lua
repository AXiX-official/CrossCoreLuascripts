-- 攻击提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer330201 = oo.class(BuffBase)
function Buffer330201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer330201:OnCreate(caster, target)
	-- 8480
	local c80 = SkillApi:GetAttr(self, self.caster, target or self.owner,6,"attack")
	-- 330201
	self:AddAttr(BufferEffect[330201], self.caster, self.card, nil, "attack",c80*0.12)
end
