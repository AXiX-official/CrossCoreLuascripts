-- 行动提前
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer24503 = oo.class(BuffBase)
function Buffer24503:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer24503:OnActionOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 24503
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddProgress(BufferEffect[24503], self.caster, target, nil, 300)
	end
	-- 24504
	self:DelBufferTypeForce(BufferEffect[24504], self.caster, self.card, nil, 24501)
end
