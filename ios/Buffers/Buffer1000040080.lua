-- 攻击敌方目标时，概率使生命值小于50%的敌方目标获得【易伤】
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040080 = oo.class(BuffBase)
function Buffer1000040080:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer1000040080:OnActionOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8259
	if SkillJudger:IsCanHurt(self, self.caster, target, true) then
	else
		return
	end
	-- 1000040080
	if self:Rand(4000) then
		self:AddNp(BufferEffect[1000040080], self.caster, self.card, nil, 100)
	end
end
