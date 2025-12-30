-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5700003 = oo.class(BuffBase)
function Buffer5700003:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5700003:OnCreate(caster, target)
	-- 5700004
	local dmg5700001 = SkillApi:GetValue(self, self.caster, target or self.owner,4,"dmg5700001")
	-- 5700003
	self:AddHp(BufferEffect[5700003], self.caster, target or self.owner, nil,-math.floor(dmg5700001*10))
	-- 5700001
	self:DelValue(BufferEffect[5700001], self.caster, self.creater, nil, "dmg5700001")
end
