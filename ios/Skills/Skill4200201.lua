-- 行进律动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4200201 = oo.class(SkillBase)
function Skill4200201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill4200201:OnActionBegin(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 4200201
	if self:Rand(3000) then
		self:AddBuff(SkillEffect[4200201], caster, caster, data, 4200201,1)
	end
end
