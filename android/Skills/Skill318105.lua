-- 协同防御
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill318105 = oo.class(SkillBase)
function Skill318105:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill318105:OnBefourHurt(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8222
	if SkillJudger:IsDamageType(self, caster, target, true,1) then
	else
		return
	end
	-- 318105
	self:AddTempAttr(SkillEffect[318105], caster, caster, data, "damage",-0.20)
end
