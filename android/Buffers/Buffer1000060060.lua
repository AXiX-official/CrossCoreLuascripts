-- 我方单位攻击处于冰冻状态的怪物时候，根据当前怪物处于的冰冻状态层数进行增伤，每个状态增伤8%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000060060 = oo.class(BuffBase)
function Buffer1000060060:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害后
function Buffer1000060060:OnAfterHurt(caster, target)
	-- 8730
	local c126 = SkillApi:BuffCount(self, self.caster, target or self.owner,2,3,3005)
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
	-- 1000060060
	self:AddAttrPercent(BufferEffect[1000060060], self.caster, self.card, nil, "damage",0.2*c126)
end
