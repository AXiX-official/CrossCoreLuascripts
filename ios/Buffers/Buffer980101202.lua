-- 乐团机制buff2效果
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer980101202 = oo.class(BuffBase)
function Buffer980101202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer980101202:OnCreate(caster, target)
	-- 8741
	local c137 = SkillApi:ClassCount(self, self.caster, target or self.owner,3,2)
	-- 980101202
	self:AddAttr(BufferEffect[980101202], self.caster, target or self.owner, nil,"crit",0.5*c137)
end
