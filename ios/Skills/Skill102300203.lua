-- 防御反击
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill102300203 = oo.class(SkillBase)
function Skill102300203:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill102300203:DoSkill(caster, target, data)
	-- 102300303
	self.order = self.order + 1
	self:AddBuff(SkillEffect[102300303], caster, target, data, 102300303)
end
-- 行动结束
function Skill102300203:OnActionOver(caster, target, data)
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
	-- 8498
	local count98 = SkillApi:BuffCount(self, caster, target,3,4,10230)
	-- 8194
	if SkillJudger:Greater(self, caster, target, true,count98,0) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 102300311
	self:BeatBack(SkillEffect[102300311], caster, self.card, data, nil,4)
end
-- 回合开始时
function Skill102300203:OnRoundBegin(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 102300313
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[102300313], caster, target, data, 10230,2)
	end
end
