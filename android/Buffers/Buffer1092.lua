-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1092 = oo.class(BuffBase)
function Buffer1092:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1092:OnCreate(caster, target)
	-- 1082
	local dmg7042 = SkillApi:GetValue(self, self.caster, target or self.owner,4,"dmg7042")
	-- 1094
	self:AddHp(BufferEffect[1094], self.caster, target or self.owner, nil,-math.floor(dmg7042*0.4))
end
