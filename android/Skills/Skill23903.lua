-- 电击III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill23903 = oo.class(SkillBase)
function Skill23903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill23903:OnAfterHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 23903
	if self:Rand(4000) then
		local targets = SkillFilter:All(self, caster, target, 2)
		for i,target in ipairs(targets) do
			self:AddBuff(SkillEffect[23903], caster, target, data, 23903)
		end
		-- 239010
		self:ShowTips(SkillEffect[239010], caster, self.card, data, 2,"破军",true,239010)
	end
end
