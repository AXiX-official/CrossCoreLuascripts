-- 刺蝽
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4503005 = oo.class(SkillBase)
function Skill4503005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害后
function Skill4503005:OnAfterHurt(caster, target, data)
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
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8822
	if SkillJudger:Less(self, caster, self.card, true,count29,1) then
	else
		return
	end
	-- 4503003
	self:HitAddBuff(SkillEffect[4503003], caster, target, data, 3000,1003,2)
end
-- 伤害前
function Skill4503005:OnBefourHurt(caster, target, data)
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
	-- 8429
	local count29 = SkillApi:BuffCount(self, caster, target,2,3,1003)
	-- 8112
	if SkillJudger:Greater(self, caster, self.card, true,count29,0) then
	else
		return
	end
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 4503006
	self:AddTempAttrPercent(SkillEffect[4503006], caster, target, data, "defense",-0.25)
end
