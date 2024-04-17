-- 钢体
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer906100601 = oo.class(BuffBase)
function Buffer906100601:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer906100601:OnRoundBegin(caster, target)
	-- 6104
	self:ImmuneBufferGroup(BufferEffect[6104], self.caster, target or self.owner, nil,1)
end
-- 暴击伤害前(OnBefourHurt之前)
function Buffer906100601:OnBefourCritHurt(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 906100601
	self:AddTempAttr(BufferEffect[906100601], self.caster, self.caster, nil, "crit_rate",-0.02*self.nCount)
	-- 906100602
	self:AddTempAttr(BufferEffect[906100602], self.caster, self.caster, nil, "crit",-0.04*self.nCount)
end
