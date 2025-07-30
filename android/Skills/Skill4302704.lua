-- 火焰
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4302704 = oo.class(SkillBase)
function Skill4302704:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill4302704:OnAddBuff(caster, target, data, buffer)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8428
	local count28 = SkillApi:BuffCount(self, caster, target,2,3,1002)
	-- 8111
	if SkillJudger:Greater(self, caster, self.card, true,count28,0) then
	else
		return
	end
	-- 4302704
	self:OwnerAddBuffCount(SkillEffect[4302704], caster, target, data, 4302704,1,1)
end
-- 暴击伤害前(OnBefourHurt之前)
function Skill4302704:OnBefourCritHurt(caster, target, data)
	-- 4302711
	local count2711 = SkillApi:GetAttr(self, caster, target,1,"crit_rate")
	-- 4302712
	local count2712 = SkillApi:GetAttr(self, caster, target,2,"crit_rate")
	-- 8428
	local count28 = SkillApi:BuffCount(self, caster, target,2,3,1002)
	-- 8111
	if SkillJudger:Greater(self, caster, self.card, true,count28,0) then
	else
		return
	end
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4302709
	self:AddTempAttr(SkillEffect[4302709], caster, caster, data, "crit",math.min((count2711-count2712)*0.8,0.8))
end
