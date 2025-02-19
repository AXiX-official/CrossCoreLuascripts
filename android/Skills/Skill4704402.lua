-- 朝晖
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4704402 = oo.class(SkillBase)
function Skill4704402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill4704402:OnActionOver(caster, target, data)
	-- 4704411
	self:OwnerAddBuffCount(SkillEffect[4704411], caster, caster, data, 704400101,1,6)
end
-- 行动结束2
function Skill4704402:OnActionOver2(caster, target, data)
	-- 8061
	if SkillJudger:CasterIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 4704402
	if self:Rand(4000) then
		local targets = SkillFilter:MinAttr(self, caster, target, 2,"hp",1)
		for i,target in ipairs(targets) do
			self:CallOwnerSkill(SkillEffect[4704402], caster, target, data, 704400402)
		end
	end
end
