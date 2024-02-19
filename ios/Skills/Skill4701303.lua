-- 丰盈之喜
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4701303 = oo.class(SkillBase)
function Skill4701303:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill4701303:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4701303
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[4701303], caster, target, data, 4701303)
	end
	-- 4701307
	self:ShowTips(SkillEffect[4701307], caster, self.card, data, 2,"丰盈之喜",true)
end
-- 死亡时
function Skill4701303:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4701306
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[4701306], caster, target, data, 4701301)
	end
	-- 4701307
	self:ShowTips(SkillEffect[4701307], caster, self.card, data, 2,"丰盈之喜",true)
end
-- 特殊入场时(复活，召唤，合体)
function Skill4701303:OnBornSpecial(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4701313
	self:OwnerAddBuff(SkillEffect[4701313], caster, caster, data, 4701303)
end
