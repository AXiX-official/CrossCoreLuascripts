-- 赤夕技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill942000202 = oo.class(SkillBase)
function Skill942000202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill942000202:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
end
-- 行动结束
function Skill942000202:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 704000202
	if self:Rand(2500) then
		self:BeatBack(SkillEffect[704000202], caster, self.card, data, nil,8)
	end
end
