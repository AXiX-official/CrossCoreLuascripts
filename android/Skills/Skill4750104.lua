-- 伏特加·镜
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4750104 = oo.class(SkillBase)
function Skill4750104:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill4750104:OnAttackOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8261
	if SkillJudger:IsCallSkill(self, caster, target, true) then
	else
		return
	end
	-- 4750104
	if self:Rand(3500) then
		self:AddBuffCount(SkillEffect[4750104], caster, target, data, 4750101,1,25)
	end
end
