-- 赤夕技能2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill704000201 = oo.class(SkillBase)
function Skill704000201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill704000201:DoSkill(caster, target, data)
	-- 11002
	self.order = self.order + 1
	self:DamagePhysics(SkillEffect[11002], caster, target, data, 0.5,2)
end
-- 行动结束
function Skill704000201:OnActionOver(caster, target, data)
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
	-- 704000201
	if self:Rand(2000) then
		self:BeatBack(SkillEffect[704000201], caster, self.card, data, nil,8)
	end
end