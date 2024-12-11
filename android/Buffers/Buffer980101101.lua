-- 山脉属性buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101101 = oo.class(BuffBase)
function Buffer980101101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980101101:OnCreate(caster, target)
	-- 8747
	local c143 = SkillApi:ClassCount(self, self.caster, target or self.owner,4,1)
	-- 980101101
	self:AddAttrPercent(BufferEffect[980101101], self.caster, target or self.owner, nil,"defense",0.2*c143)
end
