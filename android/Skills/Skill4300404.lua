-- 卡尼斯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4300404 = oo.class(SkillBase)
function Skill4300404:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill4300404:OnActionOver2(caster, target, data)
	-- 8679
	local count679 = SkillApi:BuffCount(self, caster, target,3,3,3005)
	-- 8890
	if SkillJudger:Greater(self, caster, self.card, true,count679,0) then
	else
		return
	end
	-- 4300404
	self:AddProgress(SkillEffect[4300404], caster, self.card, data, 600)
	-- 4300416
	self:DelBuff(SkillEffect[4300416], caster, self.card, data, 3004,1)
	-- 8680
	local count680 = SkillApi:BuffCount(self, caster, target,3,3,1002)
	-- 8891
	if SkillJudger:Greater(self, caster, self.card, true,count680,0) then
	else
		return
	end
	-- 4300414
	self:AddBuff(SkillEffect[4300414], caster, self.card, data, 4003,1)
	-- 4300417
	self:DelBuff(SkillEffect[4300417], caster, self.card, data, 1002,1)
end
