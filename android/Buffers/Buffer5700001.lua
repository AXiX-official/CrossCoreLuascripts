-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5700001 = oo.class(BuffBase)
function Buffer5700001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害后
function Buffer5700001:OnAfterHurt(caster, target)
	-- 8072
	if SkillJudger:TargetIsTeammate(self, self.caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8412
	local c12 = SkillApi:GetLastHitDamage(self, self.caster, target or self.owner,1)
	-- 5700002
	self:AddValue(BufferEffect[5700002], self.caster, self.card, nil, "dmg5700001",c12)
end
