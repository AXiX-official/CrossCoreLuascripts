-- 赤夕被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4704002 = oo.class(SkillBase)
function Skill4704002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill4704002:OnRoundBegin(caster, target, data)
	-- 4704002
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:SetShareDamage(SkillEffect[4704002], caster, target, data, 0.2)
	end
end
-- 伤害后
function Skill4704002:OnAfterHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8480
	local count80 = SkillApi:GetShareDamage(self, caster, target,nil)
	-- 4704011
	local targets = SkillFilter:Teammate(self, caster, target, 2)
	for i,target in ipairs(targets) do
		self:AddHp(SkillEffect[4704011], caster, target, data, -math.floor(count80))
	end
end
-- 行动结束2
function Skill4704002:OnActionOver2(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4101912
	self:AddBuff(SkillEffect[4101912], caster, self.card, data, 4101912)
end
-- 行动结束
function Skill4704002:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8633
	local count633 = SkillApi:GetDamage(self, caster, target,1)
	-- 4704022
	self:AddBuff(SkillEffect[4704022], caster, caster, data, 302301)
	-- 4704032
	self:AddHp(SkillEffect[4704032], caster, caster, data, math.floor(-count633*0.15))
end
