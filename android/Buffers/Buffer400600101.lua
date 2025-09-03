-- 烈风
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer400600101 = oo.class(BuffBase)
function Buffer400600101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer400600101:OnCreate(caster, target)
	-- 400600101
	self:AddAttr(BufferEffect[400600101], self.caster, self.card, nil, "crit",0.05*self.nCount)
	-- 8769
	local c769 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,3310)
	-- 400600102
	local targets = SkillFilter:Teammate(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:AddAttr(BufferEffect[400600102], self.caster, target, nil, "crit",0.01*self.nCount*c769)
	end
end
