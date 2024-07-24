-- 赤溟4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill334001 = oo.class(SkillBase)
function Skill334001:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill334001:OnCure(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334011
	self:AddBuffCount(SkillEffect[334011], caster, self.card, data, 304900101,1,10)
	-- 8686
	local count686 = SkillApi:SkillLevel(self, caster, target,3,3049001)
	-- 334021
	if self:Rand(1000) then
		local targets = SkillFilter:Rand(self, caster, target, 4)
		for i,target in ipairs(targets) do
			self:CallSkill(SkillEffect[334021], caster, target, data, 304900100+count686)
		end
	end
end
-- 入场时
function Skill334001:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 334001
	self:AddBuff(SkillEffect[334001], caster, self.card, data, 334001)
end
