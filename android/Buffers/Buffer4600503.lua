-- 制衡
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4600503 = oo.class(BuffBase)
function Buffer4600503:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 暴击伤害前(OnBefourHurt之前)
function Buffer4600503:OnBefourCritHurt(caster, target)
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
	-- 4600503
	self:AddTempAttr(BufferEffect[4600503], self.caster, self.caster, nil, "crit_rate",-0.2*self.nCount)
end
