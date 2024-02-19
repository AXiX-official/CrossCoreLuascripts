-- 音律通晓
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4201401 = oo.class(SkillBase)
function Skill4201401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4201401:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 4201401
	if self:Rand(6000) then
		local r = self.card:Rand(4)+1
		if 1 == r then
			-- 4201406
			local targets = SkillFilter:All(self, caster, target, 3)
			for i,target in ipairs(targets) do
				self:AddBuff(SkillEffect[4201406], caster, target, data, 4004,1)
			end
		elseif 2 == r then
			-- 4201407
			local targets = SkillFilter:All(self, caster, target, 3)
			for i,target in ipairs(targets) do
				self:AddBuff(SkillEffect[4201407], caster, target, data, 4304,1)
			end
		elseif 3 == r then
			-- 4201408
			local targets = SkillFilter:All(self, caster, target, 3)
			for i,target in ipairs(targets) do
				self:AddProgress(SkillEffect[4201408], caster, target, data, 200)
			end
		elseif 4 == r then
			-- 4201409
			local targets = SkillFilter:All(self, caster, target, 3)
			for i,target in ipairs(targets) do
				self:Cure(SkillEffect[4201409], caster, target, data, 2,0.2)
			end
		end
	end
end
