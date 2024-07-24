-- 当自身拥有【癫狂】效果时，攻击时可以提升50%暴击伤害
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000070101 = oo.class(BuffBase)
function Buffer1000070101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000070101:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 1000070052
	if SkillJudger:HasBuff(self, self.caster, target, true,2,1000070051) then
	else
		return
	end
	-- 1000070101
	self:AddAttrPercent(BufferEffect[1000070101], self.caster, target or self.owner, nil,"damage",0.5)
end
