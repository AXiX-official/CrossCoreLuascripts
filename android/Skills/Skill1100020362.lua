-- 敌方每承受1个负面效果，承受伤害增加3%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020362 = oo.class(SkillBase)
function Skill1100020362:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill1100020362:OnBefourHurt(caster, target, data)
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
	-- 8416
	local count16 = SkillApi:BuffCount(self, caster, target,2,2,2)
	-- 1100020362
	self:AddTempAttr(SkillEffect[1100020362], caster, target, data, "bedamage",0.03*count16)
end
