-- 狂暴
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4906103 = oo.class(SkillBase)
function Skill4906103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4906103:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8145
	if SkillJudger:OwnerPercentHp(self, caster, target, false,0.5) then
	else
		return
	end
	-- 4906103
	self:AddUplimitBuff(SkillEffect[4906103], caster, self.card, data, 3,3,4906103,1,4906103)
end
