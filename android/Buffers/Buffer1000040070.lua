-- 造成暴击时，有概率使敌方目标获得【易伤】（【易伤】：受到能量伤害增加20%，持续2回合）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040070 = oo.class(BuffBase)
function Buffer1000040070:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer1000040070:OnActionOver(caster, target)
	-- 8260
	if SkillJudger:IsCanHurt(self, self.caster, target, false) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000040070
	self:AddBuff(BufferEffect[1000040070], self.caster, self.card, nil, 1000010102)
	-- 1000010103
	self:AddAttr(BufferEffect[1000010103], self.caster, self.card, nil, "crit",1)
end
