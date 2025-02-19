-- 重力网
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill315101 = oo.class(SkillBase)
function Skill315101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 切换周目
function Skill315101:OnChangeStage(caster, target, data)
	-- 315101
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[315101], caster, target, data, 315101)
	end
end
-- 死亡时
function Skill315101:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 315106
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(SkillEffect[315106], caster, target, data, 315101)
	end
end
-- 特殊入场时(复活，召唤，合体)
function Skill315101:OnBornSpecial(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 315111
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:OwnerAddBuff(SkillEffect[315111], caster, target, data, 315101)
	end
end
