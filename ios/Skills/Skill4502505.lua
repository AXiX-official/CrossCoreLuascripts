-- 高卡萨斯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4502505 = oo.class(SkillBase)
function Skill4502505:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4502505:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4502506
	self:AddBuff(SkillEffect[4502506], caster, self.card, data, 6208)
end
-- 行动结束
function Skill4502505:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4502505
	self:BeatAgain(SkillEffect[4502505], caster, target, data, 502500405)
end
