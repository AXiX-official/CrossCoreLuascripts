-- 约束伤害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4400213 = oo.class(BuffBase)
function Buffer4400213:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4400213:OnCreate(caster, target)
	-- 8492
	local c92 = SkillApi:GetCount(self, self.caster, target or self.owner,4,4400203)
	-- 4400213
	self:LimitDamage(BufferEffect[4400213], self.caster, target or self.owner, nil,1,0.20*c92)
end
