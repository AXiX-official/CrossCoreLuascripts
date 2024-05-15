-- 再起I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill22801 = oo.class(SkillBase)
function Skill22801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill22801:OnBorn(caster, target, data)
	-- 22801
	self:AddBuff(SkillEffect[22801], caster, self.card, data, 6111)
end
-- 行动结束2
function Skill22801:OnActionOver2(caster, target, data)
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
	-- 30009
	self:Cure(SkillEffect[30009], caster, self.card, data, 2,0.1)
	-- 92017
	self:DelBufferForce(SkillEffect[92017], caster, self.card, data, 6111,2)
	-- 228010
	self:ShowTips(SkillEffect[228010], caster, self.card, data, 2,"重构",true,228010)
end
-- 回合开始处理完成后
function Skill22801:OnAfterRoundBegin(caster, target, data)
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
	-- 30009
	self:Cure(SkillEffect[30009], caster, self.card, data, 2,0.1)
	-- 92017
	self:DelBufferForce(SkillEffect[92017], caster, self.card, data, 6111,2)
	-- 228010
	self:ShowTips(SkillEffect[228010], caster, self.card, data, 2,"重构",true,228010)
end
