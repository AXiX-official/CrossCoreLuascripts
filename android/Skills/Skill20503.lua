-- 眩晕III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill20503 = oo.class(SkillBase)
function Skill20503:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill20503:OnActionBegin(caster, target, data)
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
	-- 8206
	if SkillJudger:IsCtrlType(self, caster, target, true,3) then
	else
		return
	end
	-- 20503
	self:AddBuff(SkillEffect[20503], caster, self.card, data, 22603)
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
	-- 205010
	self:ShowTips(SkillEffect[205010], caster, self.card, data, 2,"重击",true,205010)
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
	-- 205010
	self:ShowTips(SkillEffect[205010], caster, self.card, data, 2,"重击",true,205010)
end
