-- 造成的伤害提高20%，持续1回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030091 = oo.class(BuffBase)
function Buffer1000030091:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1000030091:OnBefourHurt(caster, target)
	-- 1000030091
	local targets = SkillFilter:All(self, self.caster, target or self.owner, nil)
	for i,target in ipairs(targets) do
		self:AddAttrPercent(BufferEffect[1000030091], self.caster, target, nil, "damage",0.2)
	end
end
