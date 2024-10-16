-- 艾穆尔
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4601503 = oo.class(SkillBase)
function Skill4601503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4601503:OnBefourHurt(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4601503
	self:AddTempAttr(SkillEffect[4601503], caster, caster, data, "damage",0.5)
end
-- 行动结束
function Skill4601503:OnActionOver(caster, target, data)
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 4601513
	if self:Rand(2500) then
		self:BeatBack(SkillEffect[4601513], caster, self.card, data, nill,7)
	end
end
-- 行动结束2
function Skill4601503:OnActionOver2(caster, target, data)
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8220
	if SkillJudger:IsCanHurt(self, caster, target, true) then
	else
		return
	end
	-- 8203
	if SkillJudger:IsSingle(self, caster, target, false) then
	else
		return
	end
	-- 4601523
	if self:Rand(6000) then
		self:BeatBack(SkillEffect[4601523], caster, self.card, data, nill,8)
	end
end
-- 攻击结束
function Skill4601503:OnAttackOver(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8244
	if SkillJudger:IsBeatBack(self, caster, target, true) then
	else
		return
	end
	-- 4601533
	self:AddBuffCount(SkillEffect[4601533], caster, self.card, data, 4601503,1,20)
end
