-- 攻击提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer330203 = oo.class(BuffBase)
function Buffer330203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer330203:OnCreate(caster, target)
	-- 8480
	local c80 = SkillApi:GetAttr(self, self.caster, target or self.owner,6,"attack")
	-- 330203
	self:AddAttr(BufferEffect[330203], self.caster, self.card, nil, "attack",c80*0.24)
end
