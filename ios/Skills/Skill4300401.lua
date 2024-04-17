-- 卡尼斯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4300401 = oo.class(SkillBase)
function Skill4300401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill4300401:OnActionOver2(caster, target, data)
	-- 8679
	local count679 = SkillApi:BuffCount(self, caster, target,3,3,3005)
	-- 8890
	if SkillJudger:Greater(self, caster, self.card, true,count679,0) then
	else
		return
	end
	-- 4300401
	self:AddProgress(SkillEffect[4300401], caster, self.card, data, 200)
	-- 4300416
	self:DelBuff(SkillEffect[4300416], caster, self.card, data, 3004,1)
	-- 8680
	local count680 = SkillApi:BuffCount(self, caster, target,3,3,1002)
	-- 8891
	if SkillJudger:Greater(self, caster, self.card, true,count680,0) then
	else
		return
	end
	-- 4300411
	self:AddBuff(SkillEffect[4300411], caster, self.card, data, 4002,1)
	-- 4300417
	self:DelBuff(SkillEffect[4300417], caster, self.card, data, 1002,1)
end
