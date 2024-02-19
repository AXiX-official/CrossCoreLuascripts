-- 受修复效果提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer23203 = oo.class(BuffBase)
function Buffer23203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer23203:OnCreate(caster, target)
	-- 8405
	local c5 = SkillApi:PercentHp(self, self.caster, target or self.owner,3)
	-- 23203
	self:AddAttr(BufferEffect[23203], self.caster, self.card, nil, "becure",math.floor((1-c5)*10)*0.06)
end
