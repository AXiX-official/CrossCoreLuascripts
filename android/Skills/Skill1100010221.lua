-- 再起II级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100010221 = oo.class(SkillBase)
function Skill1100010221:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100010221:OnBorn(caster, target, data)
	-- 22802
	self:AddBuff(SkillEffect[22802], caster, self.card, data, 6111)
end
-- 行动结束2
function Skill1100010221:OnActionOver2(caster, target, data)
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8106
	if SkillJudger:Less(self, caster, self.card, true,count20,2) then
	else
		return
	end
	-- 8424
	local count24 = SkillApi:BuffCount(self, caster, target,3,3,6111)
	-- 8107
	if SkillJudger:Greater(self, caster, self.card, true,count24,0) then
	else
		return
	end
	-- 30010
	self:Cure(SkillEffect[30010], caster, self.card, data, 2,0.3)
	-- 92017
	self:DelBufferForce(SkillEffect[92017], caster, self.card, data, 6111,2)
	-- 228010
	self:ShowTips(SkillEffect[228010], caster, self.card, data, 2,"重构",true,228010)
end
-- 回合开始处理完成后
function Skill1100010221:OnAfterRoundBegin(caster, target, data)
	-- 8420
	local count20 = SkillApi:GetAttr(self, caster, target,3,"hp")
	-- 8106
	if SkillJudger:Less(self, caster, self.card, true,count20,2) then
	else
		return
	end
	-- 8424
	local count24 = SkillApi:BuffCount(self, caster, target,3,3,6111)
	-- 8107
	if SkillJudger:Greater(self, caster, self.card, true,count24,0) then
	else
		return
	end
	-- 30010
	self:Cure(SkillEffect[30010], caster, self.card, data, 2,0.3)
	-- 92017
	self:DelBufferForce(SkillEffect[92017], caster, self.card, data, 6111,2)
	-- 228010
	self:ShowTips(SkillEffect[228010], caster, self.card, data, 2,"重构",true,228010)
end
