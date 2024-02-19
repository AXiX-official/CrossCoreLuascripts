-- 天赋效果306701
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill306701 = oo.class(SkillBase)
function Skill306701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill306701:OnBefourHurt(caster, target, data)
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
	-- 8416
	local count16 = SkillApi:BuffCount(self, caster, target,2,2,2)
	-- 8108
	if SkillJudger:Greater(self, caster, self.card, true,count16,0) then
	else
		return
	end
	-- 306701
	if self:Rand(5000) then
		self:AddTempAttrPercent(SkillEffect[306701], caster, target, data, "defense",-0.1)
	end
end
