-- 破晓II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010281 = oo.class(SkillBase)
function Skill1100010281:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击开始
function Skill1100010281:OnAttackBegin(caster, target, data)
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
	-- 1100010281
	if self:Rand(4000) then
		self:DelBufferGroup(SkillEffect[1100010281], caster, target, data, 2,1,2)
	end
end
