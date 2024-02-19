-- 翎羽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4500411 = oo.class(SkillBase)
function Skill4500411:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4500411:OnBornSpecial(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4500416
	self:CallSkill(SkillEffect[4500416], caster, self.card, data, 500410401)
end
-- 回合开始处理完成后
function Skill4500411:OnAfterRoundBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4500411
	if self:Rand(6000) then
		self:OwnerAddBuff(SkillEffect[4500411], caster, caster, data, 4500402)
	end
end
-- 解体时
function Skill4500411:OnResolve(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4500417
	self:CallSkill(SkillEffect[4500417], caster, self.card, data, 500410501)
end
