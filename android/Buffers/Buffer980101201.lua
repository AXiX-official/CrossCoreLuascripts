-- 乐团属性buff1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101201 = oo.class(BuffBase)
function Buffer980101201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980101201:OnCreate(caster, target)
	-- 8748
	local c144 = SkillApi:ClassCount(self, self.caster, target or self.owner,4,2)
	-- 980101201
	self:AddAttrPercent(BufferEffect[980101201], self.caster, target or self.owner, nil,"attack",0.2*c144)
	-- 8748
	local c144 = SkillApi:ClassCount(self, self.caster, target or self.owner,4,2)
	-- 980101202
	self:AddAttr(BufferEffect[980101202], self.caster, target or self.owner, nil,"crit",0.5*c144)
end
