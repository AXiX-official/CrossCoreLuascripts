-- 伤害引爆（把自己的存储伤害分摊到敌人身上）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1042 = oo.class(BuffBase)
function Buffer1042:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1042:OnCreate(caster, target)
	-- 1052
	local dmg4006 = SkillApi:GetValue(self, self.caster, target or self.owner,4,"dmg4006")
	-- 1060
	local Live4006 = SkillApi:GetValue(self, self.caster, target or self.owner,4,"Live4006")
	-- 1054
	self:AddHp(BufferEffect[1054], self.caster, target or self.owner, nil,math.floor(-dmg4006/(math.max((Live4006-1),1))*0.4))
end
