-- 变奏
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4200103 = oo.class(SkillBase)
function Skill4200103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4200103:OnActionOver(caster, target, data)
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
	-- 4200103
	if self:Rand(8000) then
		self:AddProgress(SkillEffect[4200103], caster, self.card, data, 200)
	end
end
