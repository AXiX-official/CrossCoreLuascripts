-- 破军II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill24102 = oo.class(SkillBase)
function Skill24102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill24102:OnAfterHurt(caster, target, data)
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
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 24102
	if self:Rand(2000) then
		self:AddProgress(SkillEffect[24102], caster, target, data, -200)
		-- 241010
		self:ShowTips(SkillEffect[241010], caster, self.card, data, 2,"震慑",true,241010)
	end
end
