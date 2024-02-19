-- 辉痕
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill320605 = oo.class(SkillBase)
function Skill320605:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill320605:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8433
	local count33 = SkillApi:BuffCount(self, caster, target,2,3,3004)
	-- 8116
	if SkillJudger:Greater(self, caster, self.card, true,count33,0) then
	else
		return
	end
	-- 320605
	self:AddTempAttr(SkillEffect[320605], caster, self.card, data, "damage",0.3)
end
-- 攻击结束
function Skill320605:OnAttackOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8433
	local count33 = SkillApi:BuffCount(self, caster, target,2,3,3004)
	-- 8116
	if SkillJudger:Greater(self, caster, self.card, true,count33,0) then
	else
		return
	end
	-- 320615
	if self:Rand(3000) then
		self:AlterBufferByID(SkillEffect[320615], caster, target, data, 3004,1)
	end
end
