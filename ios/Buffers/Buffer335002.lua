-- 暴击提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer335002 = oo.class(BuffBase)
function Buffer335002:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer335002:OnCreate(caster, target)
	-- 8484
	local c84 = SkillApi:GetAttr(self, self.caster, target or self.owner,6,"crit")
	-- 335002
	self:AddAttr(BufferEffect[335002], self.caster, self.card, nil, "crit",c84*0.18)
end
