-- 寒气
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4302501 = oo.class(SkillBase)
function Skill4302501:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4302501:OnBefourHurt(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8434
	local count34 = SkillApi:BuffCount(self, caster, target,2,3,3005)
	-- 8117
	if SkillJudger:Greater(self, caster, self.card, true,count34,0) then
	else
		return
	end
	-- 8407
	local count7 = SkillApi:GetAttr(self, caster, target,1,"speed")
	-- 8408
	local count8 = SkillApi:GetAttr(self, caster, target,2,"speed")
	-- 4302506
	self:AddTempAttr(SkillEffect[4302506], caster, target, data, "defense",math.max(math.min(-(count7-count8)*2,0),-200))
end
-- 加buff时
function Skill4302501:OnAddBuff(caster, target, data, buffer)
	-- 8434
	local count34 = SkillApi:BuffCount(self, caster, target,2,3,3005)
	-- 8117
	if SkillJudger:Greater(self, caster, self.card, true,count34,0) then
	else
		return
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 4302501
	self:OwnerAddBuffCount(SkillEffect[4302501], caster, target, data, 4302501,1,1)
end
